//
//  File.swift
//  
//
//  Created by Christopher Guirguis on 10/1/21.
//

import Foundation

public extension Collection where Element: BinaryInteger {
    /// Returns the average of all elements in the array
    func average() -> Element { isEmpty ? .zero : sum() / Element(count) }
    /// Returns the average of all elements in the array as Floating Point type
    func average<T: FloatingPoint>() -> T { isEmpty ? .zero : T(sum()) / T(count) }
}

public extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the array
    func average() -> Element { isEmpty ? .zero : Element(sum()) / Element(count) }
    
    var double: [Double] {
        self.map{ Double($0) }
    }
    var cgfloat: [CGFloat] {
        self.map{ CGFloat($0) }
    }
    var int: [Int] {
        self.map{ Int($0) }
    }
}
