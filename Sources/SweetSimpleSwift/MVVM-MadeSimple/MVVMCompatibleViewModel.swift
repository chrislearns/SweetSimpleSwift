//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

#if os(iOS)
import SwiftUI

@available(iOS, deprecated: 13.0, obsoleted: 16.0, message: "API is deprecated in iOS 10.1 and obsoleted in 9.1")
//@available(iOS, unavailable, message: "Deprecated - do not use. Support will be discontinued by 02/01/2022")
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
