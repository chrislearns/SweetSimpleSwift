//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

#if os(iOS)
import SwiftUI

public protocol HashableNavigationProtocol {
    associatedtype T: HashableDestination
    public var navUnit:HashableNavigationUnit<T> { get set }
    
    public func setupTrailingButtons()
}


//This just makes the method optional
public extension HashableNavigationProtocol {
    func setupTrailingButtons(){
        //Empty func
    }
}
#endif
