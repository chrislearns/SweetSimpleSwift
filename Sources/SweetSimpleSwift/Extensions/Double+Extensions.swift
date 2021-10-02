//
//  File.swift
//  
//
//  Created by Christopher Guirguis on 10/1/21.
//

import Foundation

public extension Double {
    func limitFractionDigits(max:Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = max
        //    print(formatter.string(from: 1.0000)!) // 1
        //    print(formatter.string(from: 1.2345)!) // 1.23
        return formatter.string(from: NSNumber(value: self)) ?? "err"
    }
    
    var cgfloat: CGFloat {return CGFloat(self)}
    var string: String { String(self) }
    var int: Int { Int(self) }
    
    
    
    
    func toDegrees() -> Double {
        self * 180.0 / .pi
    }
    
    
}
