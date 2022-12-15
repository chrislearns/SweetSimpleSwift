//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

import SwiftUI

public struct IdentifiableAnyView: Identifiable {
  public init(anyview: AnyView, id: String? = nil){
        self.anyview = anyview
    self.id = id ?? UUID().uuidString
    }
    
  public init(_ anyview: AnyView, id: String? = nil){
        self.anyview = anyview
    self.id = id ?? UUID().uuidString
    }
    public var anyview: AnyView
  public var id: String
}

