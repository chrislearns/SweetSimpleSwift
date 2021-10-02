//
//  File.swift
//  
//
//  Created by Christopher Guirguis on 10/1/21.
//

import SwiftUI

public extension CGSize {
    
    func transformed() -> CGSize {
        return CGSize(width: self.height, height: self.width)
    }
    
    func scaled(by scaler: CGFloat, x:Bool = true, y:Bool = true) -> CGSize {
        return CGSize(
            width: self.width * (x ? scaler : 1),
            height: self.height * (y ? scaler : 1))
    }
    
    func center() -> CGPoint {
        return CGPoint(x: self.width/2, y: self.height/2)
    }
    
    func toPoint() -> CGPoint {
        return .init(x: self.width, y: self.height)
    }
    
    func aspectRatioWxH() -> CGFloat {
        return self.width/self.height
    }
}
