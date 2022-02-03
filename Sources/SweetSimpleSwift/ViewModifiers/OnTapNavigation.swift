//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 12/4/21.
//
#if os(iOS)

import SwiftUI

struct OnTapNavigation<T: View>: ViewModifier {
  let preNavAction: (() -> ())?
  let postNavAction: (() -> ())?
  
  @State private var navigated: Bool = false
  var destination: T
  func body(content: Content) -> some View {
    ZStack{
      NavigationLink(isActive: $navigated){
        destination
      } label: {
        EmptyView()
      }
      content.onTapGesture {
        preNavAction?()
        navigated = true
        postNavAction?()
      }
    }
  }
}


#endif
