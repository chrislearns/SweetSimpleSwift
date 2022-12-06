//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 11/16/22.
//

import UIKit

public extension UIViewController {
  var topMostPresentedController: UIViewController {
    if let vc = self.presentedViewController {
      return vc.topMostPresentedController
    } else {
      return self
    }
  }
}
