//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

#if os(iOS)
import SwiftUI

public protocol HashableDestination: RawRepresentable, Hashable {
    associatedtype T: View
    associatedtype Y: View
    func navLink(navUnit: ObservedObject<HashableNavigationUnit<Self>>) -> T
    func destinationView(navUnit: ObservedObject<HashableNavigationUnit<Self>>) -> Y
}

public extension HashableDestination {
    func navLink(navUnit: ObservedObject<HashableNavigationUnit<Self>>) -> some View{
        let destination = destinationView(navUnit: navUnit)
        return NavigationLink(
        destination:
            destination
            .navigationTitle(navUnit.wrappedValue.navigationTitle)
            .ifLet(navUnit.wrappedValue.navigationDisplayMode){ $0.navigationBarTitleDisplayMode($1) }
            .navigationBarHidden(navUnit.wrappedValue.navigationBarHidden),
        tag: self,
        selection: navUnit.projectedValue.navigationSelector,
        label: {EmptyView()
            
        })
    }
    
    func MVVMView<B:MVVMCompatibleView>(
        type: B.Type,
        model: Any?,
        lazy: Bool = false,
        isRootNavigationView: Bool
    ) -> some View{
        Group{
            if let vModel = model as? B.ModelType {
                B.init(viewModel: vModel, isRootNavigationView: isRootNavigationView)
            }
            
            EmptyView()
            
        }.if(lazy){
            $0.lazy()
        }
    }
}
#endif
