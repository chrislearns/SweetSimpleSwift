//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/1/21.
//

import SwiftUI

public extension SpacePoint {
    
    static func < (lhs: SpacePoint, rhs: SpacePoint) -> Bool {
      return sqrt((lhs.x ^^ 2) + (lhs.y ^^ 2) + ((lhs.z ?? 0) ^^ 2)) < sqrt((rhs.x ^^ 2) + (rhs.y ^^ 2) + ((rhs.z ?? 0) ^^ 2))
    }
    func midPointFrom(to p2: CGPoint) -> CGPoint {
        return CGPoint(x: (self.x + p2.x) / 2, y: (self.y + p2.y) / 2);
    }
    
    func slope(to p2:CGPoint) -> Double {
        let deltaY = Double(p2.y - self.y)
        let deltaX = Double(p2.x - self.x)
        return deltaY/deltaX
    }
    
    init(_ size: CGSize) {
      self.init(x: size.width, y: size.height, z: nil)
    }
    
    func toSize() -> CGSize {
        return CGSize(width: self.x, height: self.y)
    }
    
    init(x: Float, y: Float){
      self.init(x: CGFloat(x), y: CGFloat(y), z: nil)
    }
    
    func offsetBy(angle:Double, distance:CGFloat) -> CGPoint{
        let newx = MathHelper.cos(degrees: angle).cgfloat * distance
        let newy = MathHelper.sin(degrees: angle).cgfloat * distance

        return self.translate(CGPoint(x: newx, y: newy))
    }
    
//    https://math.stackexchange.com/questions/656500/given-a-point-slope-and-a-distance-along-that-slope-easily-find-a-second-p
    func offsetBy(slope:Double, distance:CGFloat) -> CGPoint{
        let deltaX = (distance.double)/sqrt(1+(slope^^2))
        let deltaY = (distance.double * slope)/sqrt(1+(slope^^2))
        
        
        
        return self.translate(CGPoint(x: deltaX, y: deltaY))
    }
    
    func length() -> CGFloat {
        return sqrt(self.x * self.x + self.y * self.y)
    }
    
    func midpoint(_ point: Self) -> Self {
      let x = (self.x + point.x)
      let y = (self.y + point.y)
      let z = ((self.z ?? 0) + (point.z ?? 0))
      return Self(x: x/2,
                  y: y/2,
                  z: z/2)
    }
    
    func friendlyString() -> String {
        return "(\(String(format: "%.2f", x)), \(String(format: "%.2f", y)))"
    }
    
    func scaledBy(_ size: CGSize) -> CGPoint {
        return CGPoint(x: self.x * size.width, y: self.y * size.height)
    }
    
    
    
    func translate(_ distance:CGPoint = .zero, xPositive:Bool = true, yPositive:Bool = true) -> CGPoint{
        let x = self.x + (xPositive ? distance.x : -distance.x)
        let y = self.y + (yPositive ? distance.y : -distance.y)
        return CGPoint(
            x: x,
            y: y
        )
        
        
    }
    
}
