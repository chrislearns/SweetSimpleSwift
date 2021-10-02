//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/1/21.
//

import SwiftUI
extension Animation {
    //These are standard durations we can use in animations
    public static var shortDuration: Double {0.15}
    public static var standardDuration: Double {0.3}
    public static var longDuration: Double {1.0}
    public static var extraLongDuration: Double {2.0}
    
    //These are standard animations we can use in animations
    public static var shortEIO: Animation {Animation.easeInOut(duration: shortDuration)}
    public static var standardEIO: Animation {Animation.easeInOut(duration: standardDuration)}
    public static var longEIO: Animation {Animation.easeInOut(duration: longDuration)}
    public static var extraLongEIO: Animation {Animation.easeInOut(duration: extraLongDuration)}
    
    
    //This creates a spring animation with randomized response, dampingFraction, and blendDuration - though all of those do have upper and lower limits
    public static var randomizedSpring: Animation {
        Animation.spring(
            response: 0.4 + Double.random(in: 0..<0.2),
            dampingFraction: 0.4 + Double.random(in: 0..<0.2),
            blendDuration: 10 + Double.random(in: 0..<3))
    }
}
