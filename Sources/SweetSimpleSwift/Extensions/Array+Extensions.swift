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
public extension Array {
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

public extension Array where Element == Array<CGFloat> {
    //This takes a 2D array of CGFloat and finds the internal max
    func max() -> CGFloat? { self.compactMap{$0.max()}.max() }
}

//MARK: - Arrays - Element == CGPoint
public extension Array where Element == CGPoint {
    
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
}
