//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/1/21.
//

import Foundation

public extension Sequence where Element: AdditiveArithmetic {
    /// Returns the total sum of all elements in the sequence
    func sum() -> Element { reduce(.zero, +) }
}
