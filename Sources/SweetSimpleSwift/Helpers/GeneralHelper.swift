//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/2/21.
//


import SwiftUI
#if os(iOS)
import UIKit
#endif
import AVKit

public class GeneralHelper {
#if os(iOS)
  /// This function lets you add items to a Share Sheet/UIActivityViewController.
  /// - Parameters:
  ///   - items: items you wish to add. You can add the URL of local files. For example: file:///var/mobile/Containers/Data/Application/A72A81E0-40BB-43FF-903C-0D2D46A13C7B/Documents/tempPZDC.mov
  ///   - excludedActivityTypes: Activity types you wish to exclude
  /// - Returns: none
  public static func share(
      items: [Any],
      excludedActivityTypes: [UIActivity.ActivityType]? = nil
  ) {
      guard let source = UIApplication.shared.windows.last?.rootViewController else {
          return
      }
      let vc = UIActivityViewController(
          activityItems: items,
          applicationActivities: nil
      )
      vc.excludedActivityTypes = excludedActivityTypes
      vc.popoverPresentationController?.sourceView = source.view
      source.present(vc, animated: true)
  }
#endif
  
  public static var UniversalSafeOffsets: SafeLayout {
#if os(iOS)
    guard let window = UIApplication.shared.windows.first else {
      return SafeLayout(top: 0, bottom: 0, left: 0, right: 0)
    }
    return SafeLayout(top: window.safeAreaInsets.top,
                      bottom: window.safeAreaInsets.bottom,
                      left: window.safeAreaInsets.left,
                      right: window.safeAreaInsets.right
    )
    
#else
    return SafeLayout(top: 0, bottom: 0, left: 0, right: 0)
#endif
  }
}

public extension GeneralHelper {
  static func uniq<S : Sequence, T : Equatable >(source: S) -> [T] where S.Iterator.Element == T {
    var buffer = [T]()
    var added = Array<T>()
    for elem in source {
      if !added.contains(elem) {
        buffer.append(elem)
        added.append(elem) 
      }
    }
    return buffer
  }
}

public struct SafeLayout: Codable {
  public var top: CGFloat
  public var bottom: CGFloat
  public var left: CGFloat
  public var right: CGFloat
}
