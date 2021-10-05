//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self, Bool) -> Transform
    ) -> some View {
        
            transform(self, condition)
        
    }
    
    
    
    /* USAGE EXAMPLE
     var body: some view {
     myView
     .ifLet(optionalColor) { $0.foregroundColor($1) }
     }
     */
    @ViewBuilder
    func ifLet<V, Transform: View>(
        _ value: V?,
        transform: (Self, V) -> Transform
    ) -> some View {
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }
}

