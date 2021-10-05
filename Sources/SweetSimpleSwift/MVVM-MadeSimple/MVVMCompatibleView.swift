//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//
#if os(iOS)
import SwiftUI

protocol MVVMCompatibleView: View {
    associatedtype HD: HashableDestination
    associatedtype ModelType: MVVMCompatibleViewModel<HD>
    associatedtype T: View
    
    var viewModel: ObservedObject<ModelType> { get set }
    var navUnit: ObservedObject<HashableNavigationUnit<ModelType.T>> { get set }
    
    init(viewModel: ModelType, isRootNavigationView: Bool)
    init(viewModel: ObservedObject<ModelType>, navUnit: ObservedObject<HashableNavigationUnit<ModelType.T>>, isRootNavigationView: Bool)
    
    var mainView: T { get }
    
    var isRootNavigationView: Bool { get set }
    
}

extension MVVMCompatibleView {
    
    var body: some View {
        ZStack{
            navUnit.wrappedValue.navigationSelector?.navLink(navUnit: navUnit)
            mainView
        }
        .sheet(item: viewModel.projectedValue.sheetView) { View in
            View.anyview
        }
        .if(isRootNavigationView){
            $0.embedInNavigationView()
        }
    }
    
    
}
#endif