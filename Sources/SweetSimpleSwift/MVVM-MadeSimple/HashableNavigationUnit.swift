//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

#if os(iOS)
import SwiftUI

open class HashableNavigationUnit<Y:HashableDestination>: ObservableObject, Identifiable{
    public init(){}
    public static func == (lhs: HashableNavigationUnit, rhs: HashableNavigationUnit) -> Bool {
        return (lhs.id == rhs.id)
    }
    public let id = UUID()
    @Published public  var navigationContext: Any? = nil
    @Published public var navigationTitle: LocalizedStringKey = ""
    @Published public var navigationBarHidden: Bool = false
    @Published public var navigationDisplayMode: NavigationBarItem.TitleDisplayMode? = nil
    @Published public var navigationSelector:Y? = nil
    @Published public var isRootNavigationView: Bool = false
    
    
    public var leadingButtons:[NavigationBarButton] = []
    public var trailingButtons:[NavigationBarButton] = []
    
    public func goTo<T:ObservableObject>(
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
