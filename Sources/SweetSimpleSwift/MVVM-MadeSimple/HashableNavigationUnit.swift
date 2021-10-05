//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

#if os(iOS)
import SwiftUI

class HashableNavigationUnit<Y:HashableDestination>: ObservableObject, Identifiable{
    static func == (lhs: HashableNavigationUnit, rhs: HashableNavigationUnit) -> Bool {
        return (lhs.id == rhs.id)
    }
    let id = UUID()
    @Published var navigationContext: Any? = nil
    @Published var navigationTitle: LocalizedStringKey = ""
    @Published var navigationBarHidden: Bool = false
    @Published var navigationDisplayMode: NavigationBarItem.TitleDisplayMode? = nil
    @Published var navigationSelector:Y? = nil
    @Published var isRootNavigationView: Bool = false
    
    
    var leadingButtons:[NavigationBarButton] = []
    var trailingButtons:[NavigationBarButton] = []
    
    func goTo<T:ObservableObject>(
        selection: Y,
        context: T? = nil,
        title: LocalizedStringKey = "",
        navigationDisplayMode: NavigationBarItem.TitleDisplayMode? = nil,
        navigationBarHidden: Bool = false,
        isRootNavigationView: Bool = false
    ){
        DispatchQueue.main.async {
            self.navigationContext = context
            self.navigationTitle = title
            self.navigationDisplayMode = navigationDisplayMode
            self.navigationBarHidden = navigationBarHidden
            self.navigationSelector = selection
            self.isRootNavigationView = isRootNavigationView
        }
        
        
    }
}

#endif
