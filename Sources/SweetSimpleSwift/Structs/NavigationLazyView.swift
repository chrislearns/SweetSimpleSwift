//
//  SwiftUIView.swift
//  
//
//  Created by Chris Guirguis on 10/25/21.
//

import SwiftUI

public struct NavigationLazyView<Content: View>: View {
    public let build: () -> Content
   public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    public var body: Content {
        build()
    }
}
