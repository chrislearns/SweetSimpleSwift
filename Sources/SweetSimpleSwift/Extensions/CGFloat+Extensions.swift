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
