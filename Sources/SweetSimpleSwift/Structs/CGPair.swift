//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/2/21.
//

import SwiftUI
#if os(iOS)
public struct CGPair{
    public init(_ from: CGPoint, _ to: CGPoint){
        self.from = from
        self.to = to
    }
    
    public init(_ tuple: (CGPoint, CGPoint)){
        self.from = tuple.0
        self.to = tuple.1
    }
    
    public var from:CGPoint
    public var to:CGPoint
    
    public func slope() -> Double {
        return from.slope(to: to)
    }
    
    public func angleFromFlat() -> Double {
        return MathHelper.angleFromVectors(
            pair1: CGPair(
                CGPoint(x: 1, y: 0),
                CGPoint(x: 0, y: 0)
            ),
            pair2: self, direction: .clockwise).double
    }

    
    public func scaledBy(_ size:CGSize) -> CGPair {
        return CGPair(
            from.scaledBy(size),
            to.scaledBy(size)
        )
    }
    
    public func translate(_ distance:CGPoint) -> CGPair {
        return CGPair(
            from.translate(distance),
            to.translate(distance)
        )
    }
    
    public func distance() -> CGFloat {
        return (from - to).length()
    }
    
    public func toTuple() -> (CGPoint, CGPoint){
        return (from, to)
    }
}
#endif
