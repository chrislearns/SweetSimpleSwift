//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/8/21.
//

import SwiftUI


public extension Data {
    var asUTF8String: String? {
        String(data: self, encoding: .utf8)
    }
    
}
