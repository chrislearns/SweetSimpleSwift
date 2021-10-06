//
//  SwiftUIView.swift
//  
//
//  Created by Chris Guirguis on 10/6/21.
//
#if os(iOS)

import SwiftUI
import UIKit

public extension Color {
    public var uiColor: UIColor{
        return UIColor(self)
    }
}

#endif
