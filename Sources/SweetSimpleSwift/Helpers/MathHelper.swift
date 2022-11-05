//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/1/21.
//


import SwiftUI
import Accelerate.vecLib.LinearAlgebra


public class MathHelper {
    public static func solveSystemOfEquations(matrix:[[Double]], vector:[Double])->[Double]{
        var result: [Double] = Array(repeating: 0.0, count: vector.count)
        let flatMatrix = matrix.flatMap({$0})
        
        let laMatrix:la_object_t =
            la_matrix_from_double_buffer(flatMatrix,  la_count_t(matrix.count),  la_count_t(matrix[0].count),  la_count_t(matrix[0].count), la_hint_t(LA_NO_HINT), la_attribute_t(LA_DEFAULT_ATTRIBUTES))
        let laVector = la_matrix_from_double_buffer(vector, la_count_t(vector.count), 1, 1, la_hint_t(LA_NO_HINT), la_attribute_t(LA_DEFAULT_ATTRIBUTES))
        let vecCj = la_solve(laMatrix, laVector)
        
        let status = la_matrix_to_double_buffer(&result, 1, vecCj)
        
        if status == la_status_t(LA_SUCCESS) {
            return result
        } else {
            return [Double]()
        }
    }
    
    public static func sin(degrees: Double) -> Double {
        return __sinpi(degrees/180.0)
    }

    public static func cos(degrees: Double) -> Double {
        return __cospi(degrees/180.0)
    }
    
    public static func angleFromTwoSlopes(_ m1: Double, _ m2:Double) -> (angles: (acute: Double, obtuse: Double, original: Double, originalPositive: Double), argument: Double){
        
        let numerator = m2 - m1
        let denominator = (1 + (m1 * m2))
        let angle = Angle(radians: atan(numerator/denominator))
        let original = angle.degrees
        var degrees = angle.degrees
        while degrees < 0 {
            degrees += 360
        }
        while degrees > 360 {
            degrees -= 360
        }
        
        let originalPositive = original > 0 ? original : original + 180
        if degrees > 180 {
            return ((360 - degrees, degrees, original, originalPositive), numerator/denominator)
        } else {
            return ((degrees, 360 - degrees, original, originalPositive), numerator/denominator)
        }
    }
    
    //These functions were an attempt to gather a slope based on 3 points but it was not efficient/had issues with +/- signs
    public static func lineIntercept(slope: CGFloat, point:CGPoint) -> CGFloat {
        //This is based on the point slope formula: y = mx+b  ----> b = y-mx
        return point.y - (slope * point.x)
    }
    
    public static func intersectionOfTwoLines(line1: (CGPoint, CGPoint), line2: (CGPoint, CGPoint)) -> CGPoint{
        //First find the slope of the lines
        let m1 = line1.0.slope(to: line1.1).cgfloat
        let m2 = line2.0.slope(to: line2.1).cgfloat
        
        //Next find the b-intercept of each line
        let b1 = lineIntercept(slope: m1, point: line1.1)
        let b2 = lineIntercept(slope: m2, point: line2.1)
        
        
        if (abs(m1) == .infinity && abs(m2) == .infinity) || (m1 == m2){
            //            print("error - looking for the intersection of 2 lines that do not intersect")
            return CGPoint(x: 1000000000, y: 1000000000)
        } else if abs(m1) == .infinity {
            let xConstant = line1.0.x
            //            print("this means that we have a straight vertical line where x1 = \(xConstant)")
            let intersectionX = xConstant
            let intersectionY = (m2 * intersectionX) + b2
            return CGPoint(x: intersectionX, y: intersectionY)
        } else if abs(m2) == .infinity {
            let xConstant = line2.0.x
            //            print("this means that we have a straight vertical line where x2 = \(xConstant)")
            let intersectionX = xConstant
            let intersectionY = (m1 * intersectionX) + b1
            return CGPoint(x: intersectionX, y: intersectionY)
        } else {
            //By setting two lines equal to eachother and solving for x, the outcome is the following
            let intersectionX = (b2-b1)/(m1-m2)
            
            
            //Now just plug the x value of the intersection into either line equation and it will give you the respective y
            let intersectionY = (m1 * intersectionX) + b1
            
            return CGPoint(x: intersectionX, y: intersectionY)
        }
    }
    
    public static func angleFromThreePoints(vertex: CGPoint, point1:CGPoint, point2:CGPoint) -> CGFloat{
        //    The formula for the angle from 3 points is:
        //    angle = acos{[(P12^2)+(P13^2)-(P23^2)]/[2*(P12)*(P13)]}
        //    Where PXY is the distance between points X and Y; and it is assumed that P1 is the vertex
        //    So in terms of the parameters of this function, the equation is:
        //    angle = acos{[(PV1^2)+(PV2^2)-(P12^2)]/[2*(PV1)*(PV2)]}
        
        let PV1 = CGPair(vertex, point1).distance()
        let PV2 = CGPair(vertex, point2).distance()
        let P12 = CGPair(point1, point2).distance()
        print(PV1)
        print(PV2)
        print(P12)
        
        let numerator = (PV1 ^^ 2) + (PV2 ^^ 2) - (P12 ^^ 2)
        let denonminator = 2 * (PV1) * (PV2)
        let arg = numerator/denonminator
        let rad = acos(arg.double)
        let angle = Angle(radians: rad)
        return angle.degrees.cgfloat
        
    }
    
    //These functions were used to get an angle in the clockwise direction based on 2 vectors and using linear algebra;
    public static func dotAndDet(pair1: (CGPoint, CGPoint), pair2: (CGPoint, CGPoint)) -> (dot: CGFloat, det: CGFloat) {
        let vector1 = CGVector(dx: pair1.1.x - pair1.0.x, dy: pair1.1.y - pair1.0.y)
        let vector2 = CGVector(dx: pair2.1.x - pair2.0.x, dy: pair2.1.y - pair2.0.y)
        let dot = (vector1.dx * vector2.dx) + (vector1.dy * vector2.dy)
        let det = (vector1.dx * vector2.dy) - (vector1.dy * vector2.dx)
        //    print("dot = ", dot, " || det = ", det)
        return (dot: dot, det: det)
    }
    
    public static func angleFromVectors(pair1: CGPair, pair2: CGPair, direction:ClockwiseCounterclockwise) -> CGFloat{
        let dotdet = dotAndDet(pair1: pair1.toTuple(), pair2: pair2.toTuple())
        let radAngle = atan2(dotdet.det, dotdet.dot).double
        let angle = Angle(radians: radAngle)
        var degrees = angle.degrees.cgfloat
        if degrees < 0 {
            degrees += 360
        }
        return direction == .clockwise ? degrees : 360 - degrees
    }
  
  public static func scalePair(pair: (CGPoint, CGPoint), scale: (width: CGFloat, height: CGFloat)) -> (CGPoint, CGPoint){
      return (CGPoint(x: pair.0.x * scale.width, y: pair.0.y * scale.height),
              CGPoint(x: pair.1.x * scale.width, y: pair.1.y * scale.height))
  }

  public static func multiplyFunc(_ a: [Double], _ b: [Double]) -> [Double] {
      return zip(a,b).map(*)
  }

  public static func linearRegression(_ xs: [Double], _ ys: [Double]) -> (slope:Double, intercept:Double) {
      let sum1 = multiplyFunc(ys, xs).average() - xs.average() * ys.average()
      let sum2 = multiplyFunc(xs, xs).average() - pow(xs.average(), 2)
      let slope = sum1 / sum2
      let intercept = ys.average() - slope * xs.average()
      return (slope, intercept)
  }

  public static func rSquared(line:(slope:Double, intercept:Double), points:[CGPoint]) -> Double {
      let rss:Double = points.map{(
          (((line.slope * $0.x.double) + line.intercept) - $0.y.double) ^^ 2
      )}.reduce(0, +)
      
      let tss:Double = points.map{(
          ($0.y.double - points.map{$0.y.double}.average()) ^^ 2
      )}.reduce(0, +)
      return 1 - (rss/tss)
  }
}

