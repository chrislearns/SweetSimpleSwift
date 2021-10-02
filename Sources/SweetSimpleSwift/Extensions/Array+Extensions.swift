//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/1/21.
//

import SwiftUI
import Vision
import SpriteKit
import AVKit

//MARK: - Arrays - All Element Types
extension Array {
    //This function allows you to add things in a round robin fashion. The first thing in the array gets removed and the new item gets added to the end of the array.
    //(item) refers to the thing you're going to add, and (threshold) refers to the upperlimit of things that can go in the array. It's once the array item count reaches the threshold that round robin begins instaead of standard .append of the item into the array
    mutating func roundRobin(_ item: Element, _ threshold:Int){
        if self.count >= threshold {
            _ = self.removeFirst()
            self.append(item)
        } else {
            self.append(item)
        }
    }
    
    func mapToSet<T: Hashable>(_ transform: (Element) -> T) -> Set<T> {
            var result = Set<T>()
            for item in self {
                result.insert(transform(item))
            }
            return result
        }
}

extension Array where Element == Array<CGFloat> {
    //This takes a 2D array of CGFloat and finds the internal max
    func max() -> CGFloat? { self.compactMap{$0.max()}.max() }
}

//MARK: - Arrays - Element == CGPoint
extension Array where Element == CGPoint {
    
    /*This function takes an array of doubles and finds the smallest and largest of the x and y values. From there it finds the distance between 2 theoretical points:
     - Point 1 = (XMin, YMin)
     - Point 2 = (XMax, YMax)
     */
    func greatestDistance() -> Double? {
        if
            let Ymax = self.map({$0.y}).max(),
            let Ymin = self.map({$0.y}).min(),
            let Xmax = self.map({$0.x}).max(),
            let Xmin = self.map({$0.x}).min(){
            let deltaY2 = (Ymax - Ymin) ^^ 2
            let deltaX2 = (Xmax - Xmin) ^^ 2
            let squareroot = Double(sqrt(deltaX2 + deltaY2))
            //                        print("Δx² = \(deltaX2)  ---   Δy² = \(deltaY2)")
            //            print("√(Δx² + Δy²) = \(squareroot)")
            return squareroot
        } else {
            return nil
        }
    }
    
    //This function just returns the average of all x values and the average of all y values in the form of a CGPoint --> CGPoint(averageX, averageY)
    func averagePoint() -> CGPoint {
        let averageX = self.map({$0.x}).average()
        let averageY = self.map({$0.y}).average()
        return CGPoint(x: averageX, y: averageY)
    }
    
    
    //This function finds the quadratic equation that best fits a set of points
    func quadraticEquation() -> QuadraticEquation{
            let x4 = self.map({$0.x ^^ 4}).reduce(0, +).double
            let x3 = self.map({$0.x ^^ 3}).reduce(0, +).double
            let x2 = self.map({$0.x ^^ 2}).reduce(0, +).double
            let x1 = self.map({$0.x}).reduce(0, +).double
            
            let x1y1 = self.map({$0.x * $0.y}).reduce(0, +).double
            let x2y1 = self.map({($0.x ^^ 2) * $0.y}).reduce(0, +).double
            let y1 = self.map({$0.y}).reduce(0, +).double
            let n = Double(self.count)
            
            let matrix:[[Double]] = [
                [x4, x3, x2],
                [x3, x2, x1],
                [x2, x1, n],
            ]
            
            let vector:[Double] = [x2y1, x1y1, y1]
            let vals = MathHelper.solveSystemOfEquations(matrix: matrix, vector: vector)
        return QuadraticEquation(a: vals[0], b: vals[1], c: vals[2], points: self)
        }
    
}
