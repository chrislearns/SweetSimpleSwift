//
//  SwiftUIView.swift
//  
//
//  Created by Chris Guirguis on 11/30/21.
//

#if os(iOS)
import SwiftUI

public struct IdentifiableAlert: Identifiable {
    public init(alert: Alert){
        self.alert = alert
    }
    
    public init(_ alert: Alert){
        self.alert = alert
    }
    public var alert: Alert
    public let id = UUID()
}

#endif
