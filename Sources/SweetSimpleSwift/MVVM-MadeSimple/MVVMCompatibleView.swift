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
    
    public var viewModel: ObservedObject<ModelType> { get set }
    public var navUnit: ObservedObject<HashableNavigationUnit<ModelType.T>> { get set }
    
    public init(viewModel: ModelType, isRootNavigationView: Bool)
    public init(viewModel: ObservedObject<ModelType>, navUnit: ObservedObject<HashableNavigationUnit<ModelType.T>>, isRootNavigationView: Bool)
    
    public var mainView: T { get }
    
    public var isRootNavigationView: Bool { get set }
    
}

extension MVVMCompatibleView {
    
    public var body: some View {
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
