//
//  SpacePoint.swift
//  
//
//  Created by Christopher Guirguis on 11/4/22.
//

import SwiftUI

public protocol SpacePoint: Codable, AdditiveArithmetic {
  init(x: CGFloat, y: CGFloat, z: CGFloat?)
  var x: CGFloat { get }
  var y: CGFloat { get }
  var z: CGFloat? { get }
  
  
}

extension CGPoint: SpacePoint {
  public init(x: CGFloat, y: CGFloat, z: CGFloat?) {
    self.init(x: x, y: y)
  }
  
  public var z: CGFloat? { nil }
}
