//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

#if os(iOS)
import SwiftUI

open class MVVMCompatibleViewModel<T: HashableDestination>: ObservableObject, HashableNavigationProtocol {
    @Published public var navUnit: HashableNavigationUnit<T> = .init()
    @Published public var sheetView: IdentifiableAnyView? = nil
    
    public init(){}
    public typealias T = T
    
    public func hideKeyboard(){
        KeyboardHelper.endediting()
    }
}

#endif
