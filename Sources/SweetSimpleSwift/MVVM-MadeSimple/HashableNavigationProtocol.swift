//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

#if os(iOS)
import SwiftUI

protocol HashableNavigationProtocol {
    associatedtype T: HashableDestination
    var navUnit:HashableNavigationUnit<T> { get set }
    
    func setupTrailingButtons()
}


//This just makes the method optional
extension HashableNavigationProtocol {
    func setupTrailingButtons(){
        //Empty func
    }
}
#endif
