//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/1/21.
//

import SwiftUI
public extension Animation {
    //These are standard durations we can use in animations
    static var shortDuration: Double {0.15}
    static var standardDuration: Double {0.3}
    static var longDuration: Double {1.0}
    static var extraLongDuration: Double {2.0}
    
    //These are standard animations we can use in animations
    static var shortEIO: Animation {Animation.easeInOut(duration: shortDuration)}
    static var standardEIO: Animation {Animation.easeInOut(duration: standardDuration)}
    static var longEIO: Animation {Animation.easeInOut(duration: longDuration)}
    static var extraLongEIO: Animation {Animation.easeInOut(duration: extraLongDuration)}
    
    
    //This creates a spring animation with randomized response, dampingFraction, and blendDuration - though all of those do have upper and lower limits
    static var randomizedSpring: Animation {
        Animation.spring(
            response: 0.4 + Double.random(in: 0..<0.2),
            dampingFraction: 0.4 + Double.random(in: 0..<0.2),
            blendDuration: 10 + Double.random(in: 0..<3))
    }
}
