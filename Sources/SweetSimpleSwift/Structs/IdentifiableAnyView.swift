//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

#if os(iOS)
import SwiftUI

struct IdentifiableAnyView: Identifiable {
    var anyview: AnyView
    let id = UUID()
}

#endif
