//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/1/21.
//
#if os(iOS)
import SwiftUI

public extension CGPoint {
    
    static func < (lhs: CGPoint, rhs: CGPoint) -> Bool {
        return sqrt((lhs.x ^^ 2) + (lhs.y ^^ 2)) < sqrt((rhs.x ^^ 2) + (rhs.y ^^ 2))
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
        self.init()
        self.x = size.width
        self.y = size.height
    }
    
    func toSize() -> CGSize {
        return CGSize(width: self.x, height: self.y)
    }
    
    init(x: Float, y: Float){
        self.init(x: CGFloat(x), y: CGFloat(y))
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
    
    func midpoint(_ point: CGPoint) -> CGPoint {
        return (self + point) / 2
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
#endif
