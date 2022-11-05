//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/2/21.
//

import SwiftUI

public struct CGPair<S: SpacePoint>{
    public init(_ from: S, _ to: S){
        self.from = from
        self.to = to
    }
    
    public init(_ tuple: (S, S)){
        self.from = tuple.0
        self.to = tuple.1
    }
    
    public var from:S
    public var to:S
    
    public func slope() -> Double {
        return from.slope(to: to)
    }
    
    public func angleFromFlat() -> Double {
        return MathHelper.angleFromVectors(
            pair1: CGPair(
              S(x: 1, y: 0, z: nil),
              S(x: 0, y: 0, z: nil)
            ),
            pair2: self, direction: .clockwise).double
    }

    
    public func scaledBy(_ size:CGSize) -> CGPair {
        return CGPair(
            from.scaledBy(size),
            to.scaledBy(size)
        )
    }
    
    public func translate(_ distance:S) -> CGPair {
        return CGPair(
            from.translate(distance),
            to.translate(distance)
        )
    }
    
    public func distance() -> CGFloat {
        return (from - to).length()
    }
    
    public func toTuple() -> (S, S){
        return (from, to)
    }
}

public struct CG3DPoint: SpacePoint {
  public static func + (lhs: CG3DPoint, rhs: CG3DPoint) -> CG3DPoint {
    let x = (lhs.x + rhs.x)
    let y = (lhs.y + rhs.y)
    let z = ((lhs.z ?? 0) + (rhs.z ?? 0))
    return .init(x: x, y: y, z: z)
  }
  
  public static var zero: CG3DPoint = .init(x: 0, y: 0, z: 0)
  
  public init(x: CGFloat, y: CGFloat, z: CGFloat?) {
    self.x = x
    self.y = y
    self.z = z
  }
  
  public var x: CGFloat
  public var y: CGFloat
  public var z: CGFloat?
  
  public static func -(lhs: Self, rhs: Self) -> Self {
    let x = (lhs.x - rhs.x)
    let y = (lhs.y - rhs.y)
    let z = ((lhs.z ?? 0) - (rhs.z ?? 0))
    return .init(x: x, y: y, z: z)
  }
}
