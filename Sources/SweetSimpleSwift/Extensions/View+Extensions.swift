//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

import SwiftUI

#if os(iOS)
public extension View {
    @ViewBuilder
    public func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    public func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self, Bool) -> Transform
    ) -> some View {
        
        transform(self, condition)
        
    }
    
    
    
    /* USAGE EXAMPLE
     var body: some view {
     myView
     .ifLet(optionalColor) { $0.foregroundColor($1) }
     }
     */
    @ViewBuilder
    public func ifLet<V, Transform: View>(
        _ value: V?,
        transform: (Self, V) -> Transform
    ) -> some View {
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }
}




public extension View {
    public func lazy() -> some View{
        Lazy(self)
    }
    
    public func withEnvironmentObjects<EVs:ObservableObject, V: View>(_ vars: [EVs]) -> some View {
        
        var v: V = self as! V
        for object in vars {
            v = v.environmentObject(object) as! V
        }
        
        return v
        
    }
    
    public func embedInNavigationView() -> some View {
        NavigationView{self}
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    public func embedInButton(action: @escaping () -> ()) -> some View{
        Button(action: action){
            self
        }
    }
    
    
    public func embedInScrollView() -> some View {
        ScrollView{
            self
        }
    }
    public func embedInNavigationLink<T: View>(destination: T) -> some View{
        NavigationLink(destination: {destination}) {
            self
        }
    }
    
    
    public func embedInZStack() -> some View {
        ZStack{
            self
        }
    }
    
    public func embedInVStack() -> some View {
        VStack{
            self
        }
    }
    
    public func embedInHStack() -> some View {
        HStack{
            self
        }
    }
    
    public func infiniteWidth(_ alignment: Alignment = .leading) -> some View{
        self.frame(maxWidth: .infinity, alignment: alignment)
        
    }
    
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }

    public func onTapNavigation<T: View>(destination: (() -> T)) -> some View{
      return self.modifier(OnTapNavigation(destination: destination()))
    }
  
}


#endif

