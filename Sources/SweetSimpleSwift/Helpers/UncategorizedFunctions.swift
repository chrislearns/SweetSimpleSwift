//
//  File.swift
//  
//
//  Created by Christopher Guirguis on 10/1/21.
//

import Foundation

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func += (left: inout CGPoint, right: CGPoint) {
    left = left + right
}

public func -= (left: inout CGPoint, right: CGPoint) {
    left = left - right
}

public func / (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right, y: left.y / right)
}

public func * (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right)
}

public func /= (left: inout CGPoint, right: CGFloat) {
    left = left / right
}

public func *= (left: inout CGPoint, right: CGFloat) {
    left = left * right
}

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
public func ^^ (radix: Double, power: Double) -> Double {
    return pow(Double(radix), Double(power))
}
public func ^^ (radix: CGFloat, power: CGFloat) -> CGFloat {
    return pow(CGFloat(radix), CGFloat(power))
}


