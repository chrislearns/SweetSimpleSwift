//
//  RoundedCorner.swift
//  
//
//  Created by Christopher Guirguis on 11/23/21.
//
#if os(iOS)


import SwiftUI
import UIKit

public struct RoundedCorner: Shape {
    public var radius: CGFloat = .infinity
    public var corners: UIRectCorner = .allCorners
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#endif
