//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

import SwiftUI

public struct IdentifiableAnyView: Identifiable {
  public init(anyview: AnyView, id: String = UUID().uuidString){
        self.anyview = anyview
    self.id = id
    }
    
  public init(_ anyview: AnyView, id: String = UUID().uuidString){
        self.anyview = anyview
    self.id = id
    }
    public var anyview: AnyView
  public var id: String
}

