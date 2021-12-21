//
//  File.swift
//  
//
//  Created by Christopher Guirguis on 10/1/21.
//

import SwiftUI

public extension CGFloat {
    var double:Double{Double(self)}
    
    var int:Int{Int(self)}
    
    func limitFractionDigits(max:Int) -> String {
        let doubVal = self.double
        return doubVal.limitFractionDigits(max: max)
    }
}

//MARK: - Font Extension
public extension CGFloat {
    static var extraLargeSize: CGFloat {70.0}
    static var largeSize: CGFloat {50.0}
    static var mediumSize: CGFloat {30.0}
    static var smallSize: CGFloat {20.0}
    static var extraSmallSize: CGFloat {14.6}
    static var extraExtraSmallSize: CGFloat {10.0}
}
