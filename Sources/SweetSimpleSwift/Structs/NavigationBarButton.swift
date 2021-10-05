//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/5/21.
//

#if os(iOS)
import SwiftUI

public struct NavigationBarButton:Identifiable{
    public let id = UUID()
    
    //Note that the image can either be designated with a systemName or imageName. There are corresponding initializers. If you go the systemName route then you are using SFSymbols. Otherwise you are writing the string of the image you'll be grabbing from the XCAssets
    public var systemName:String?
    public var imageName:String?
    
    //This is the closure that contains the code that gets executed upon tapping the button.
    public var buttonAction:() -> ()
    
    //This initializer is for SFSymbols
    public init(systemName: String, buttonAction: @escaping ()->()){
        self.systemName = systemName
        self.buttonAction = buttonAction
    }
    
    //This initializer is for regular images
    public init(imageName: String, buttonAction: @escaping ()->()){
        self.imageName = imageName
        self.buttonAction = buttonAction
    }
    
    public func image() -> some View {
        Group{
            if let systemName = systemName {
                Image(systemName: systemName)
            } else if let imageName = imageName{
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
            } else {
                EmptyView()
            }
        }
    }
}

#endif
