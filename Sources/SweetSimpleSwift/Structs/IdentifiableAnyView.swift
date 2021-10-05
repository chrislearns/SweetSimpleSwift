//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

#if os(iOS)
import SwiftUI

public struct IdentifiableAnyView: Identifiable {
    var anyview: AnyView
    let id = UUID()
}

#endif
