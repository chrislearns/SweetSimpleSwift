//
//  File.swift
//  
//
//  Created by Christopher Guirguis on 10/1/21.
//

import SwiftUI

//MARK: - Quadratic Regression Logic
/*
 Sources:
 https://developer.apple.com/documentation/accelerate/working_with_matrices
 https://tutorme.com/blog/post/quadratic-regression/
 https://www.varsitytutors.com/hotmath/hotmath_help/topics/quadratic-regression
 */

public struct QuadraticEquation {
    public let a:Double
    public let b:Double
    public let c:Double
    
    public let points:[CGPoint]
    
    public var pointOfInflection:CGPoint{
        //Find the point of inflection by setting the derivative of the equation equal to 0 and solving for the x-value
        //0 = 2a(x) + b   --->   -b/2a = x
        let xVal = -b/(2 * a)
        let yVal = (a * (xVal ^^ 2)) + (b * xVal) + (c)
        
        return .init(x: CGFloat(xVal), y: CGFloat(yVal))
        
    }
    
    //This enum is used to dermine the opening direction
    public enum UpDown{
        case up, down
    }
    
    public var openingDirection:UpDown{
        a > 0 ? .up : .down
    }
    
    
    /*
     Normalized fraction is used to determine which points to remove. For example, imagine a parabola that opens down and has a min value of 2 and a max value of 92 at the vertex. If we have a normalizedFraction of 0.5 then we're asking for the following things:
     a) Tranlsate the array so the min y-value is 0
     --> (2,92) -> (0,90)
     b) Find the threshold for inclusion into the truncated set of points
     --> if normalizedFraction = 0.5 then the cutoff point is 45
     */
    
    public func truncatedPoints(normalizedFraction: CGFloat) -> (
        truncationStartIndex: Int,
        truncationEndIndex: Int
    )? {
        //We need to trim the data to remove the head and tail from the data. There are typically some lag phases where things arent happening, on either end of the event we're aiming to track.
        
        if let min = self.points.map({$0.y}).min(),
           let max = self.points.map({$0.y}).max()
        {
            
            print("original rnage = \(min) -> \(max)")
            //(a) Translate the array
            let translatedPoints = self.points.map{CGPoint(x: $0.x, y: ($0.y - min))}
            print("translated range = \(translatedPoints.map({$0.y}).min() ?? -1) -> \(translatedPoints.map({$0.y}).max() ?? -1)")
            let threshold = (max - min) * (normalizedFraction)
            print("threshold = \(threshold)")
            
            switch self.openingDirection {
            case .up:
                if let startIndex = translatedPoints.firstIndex(where: {$0.y <= threshold}),
                   let endIndex = translatedPoints.lastIndex(where: {$0.y <= threshold}){
                    print("up opening trend could not find startIndex or endIndex")
                    return (Int(startIndex), Int(endIndex))
                    
                }
            case .down:
                if let startIndex = translatedPoints.firstIndex(where: {$0.y >= threshold}),
                   let endIndex = translatedPoints.lastIndex(where: {$0.y >= threshold}){
                    return (Int(startIndex), Int(endIndex))
                } else {
                    print("down opening trend could not find startIndex or endIndex")
                }
            }
            
            return nil
            
        } else {
            print("somehow unable to unwrap a min or max value for the y-values in the array")
            return nil
        }
    }
}
