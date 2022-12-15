//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

import SwiftUI


public extension View {
    @ViewBuilder
    func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func `if`<Transform: View>(
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
    func ifLet<V, Transform: View>(
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
     func lazy() -> some View{
       Lazy(self)
     }
    
     func withEnvironmentObjects<EVs:ObservableObject, V: View>(_ vars: [EVs]) -> some View {
        
        var v: V = self as! V
        for object in vars {
            v = v.environmentObject(object) as! V
        }
        
        return v
        
    }
    
  func embedInNavigationView() -> some View {
    NavigationView{self}
#if os(iOS)
    .navigationViewStyle(StackNavigationViewStyle())
#endif
  }
  
  func embedInButton(action: @escaping () -> ()) -> some View{
        Button(action: action){
            self
        }
    }
    
    
    func embedInScrollView() -> some View {
        ScrollView{
            self
        }
    }
     func embedInNavigationLink<T: View>(destination: T) -> some View{
        NavigationLink(destination: {destination}) {
            self
        }
    }
    
    
     func embedInZStack() -> some View {
        ZStack{
            self
        }
    }
    
     func embedInVStack() -> some View {
        VStack{
            self
        }
    }
    
     func embedInHStack() -> some View {
        HStack{
            self
        }
    }
  
   func embedInAnyView() -> AnyView {
      AnyView(
          self
      )
  }
  
  func embedInIdentifiableAnyView(id: String? = nil) -> IdentifiableAnyView {
    IdentifiableAnyView(
      anyview: self.embedInAnyView(),
      id: id
    )
    
  }
  
    func infiniteWidth(_ alignment: Alignment = .leading) -> some View{
        self.frame(maxWidth: .infinity, alignment: alignment)
        
    }
    
  #if os(iOS)
     func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }

    func onTapNavigation<T: View>(preNavAction: (() -> ())? = nil,
                                  postNavAction: (() -> ())? = nil,
                                  destination: (() -> T)) -> some View{
      return self.modifier(OnTapNavigation(preNavAction: preNavAction, postNavAction: postNavAction, destination: destination()))
    }
  
  
#endif


  
}

