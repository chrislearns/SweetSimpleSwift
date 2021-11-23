//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 11/2/21.
//

#if os(iOS)
import SwiftUI
import UIKit

public struct VisualEffectView: UIViewRepresentable {
    public init(effect: UIVisualEffect?){
        self.effect = effect
    }
    public var effect: UIVisualEffect?
    public func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    public func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

#endif
