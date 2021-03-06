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
  public static func takeScreenshot(orientation: UIImage.Orientation, sampleBuffer:CMSampleBuffer?) -> Data?{
    
    func takeSC(_ shouldSave: Bool = true) -> UIImage? {
      var screenshotImage :UIImage?
      //This method below was deprecated so we moved to the version below it
      //let layer = UIApplication.shared.keyWindow!.layer
      let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first
      
      let layer = keyWindow?.layer
      let scale = UIScreen.main.scale
      guard let layer = layer else {return nil}
      UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
      guard let context = UIGraphicsGetCurrentContext() else {return nil}
      layer.render(in:context)
      screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
      //                            UIGraphicsEndImageContext()
      if let image = screenshotImage, shouldSave {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
      }
      
      return screenshotImage
    }
    
    //            print("samp -> \(currentSample)")
    if let cameraPreviewSC = sampleBuffer?.toImage(
      orientation:
        orientation) {
      
      if let overallSC = takeSC(false) {
        var overlayedImage: some View {
          ZStack{
            Image(uiImage: cameraPreviewSC)
              .resizable()
              .scaledToFit()
            Image(uiImage: overallSC)
              .resizable()
              .padding()
              .scaledToFit()
          }.frame(width: 800, height: 800)
        }
        
        return overallSC.pngData()
        
      }
      
      
    } else {
      print("couldnt take camera preview screenshot")
    }
    
    return nil
  }
  
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
