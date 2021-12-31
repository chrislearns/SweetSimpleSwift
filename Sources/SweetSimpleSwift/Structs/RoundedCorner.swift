//
//  OnTapNavigation.swift
//  
//
//  Created by Christopher Guirguis on 11/23/21.
//



import SwiftUI
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif





#if os(iOS)
public struct RoundedCorner: Shape {
    public var radius: CGFloat = .infinity
    public var corners: UIRectCorner = .allCorners
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
#elseif os(macOS)
public struct RoundedCorner: Shape {
    public var radius: CGFloat = .infinity
    public var corners: NSRect = .allCorners
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
#endif
