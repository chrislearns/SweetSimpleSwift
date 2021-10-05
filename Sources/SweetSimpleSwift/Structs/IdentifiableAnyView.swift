//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

#if os(iOS)
import SwiftUI

public struct IdentifiableAnyView: Identifiable {
    public var anyview: AnyView
    public let id = UUID()
}

#endif
