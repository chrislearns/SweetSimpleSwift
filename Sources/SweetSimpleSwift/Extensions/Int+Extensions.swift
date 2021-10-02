//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/2/21.
//

import SwiftUI

extension Int {
    var secondToMinute:(minute:Int, second:Int){
        return (self/60, self%60)
    }
    
    var string: String { String(self) }
    var double: Double { Double(self) }
}
