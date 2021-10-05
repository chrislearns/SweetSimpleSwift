//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

#if os(iOS)
import SwiftUI

class MVVMCompatibleViewModel<T: HashableDestination>: ObservableObject, HashableNavigationProtocol {
    @Published var navUnit: HashableNavigationUnit<T> = .init()
    @Published var sheetView: IdentifiableAnyView? = nil
    
    typealias T = T
    
    func hideKeyboard(){
        KeyboardHelper.endediting()
    }
}

#endif
