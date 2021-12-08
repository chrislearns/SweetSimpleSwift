//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/2/21.
//
#if os(iOS)

import SwiftUI
import UIKit
import AVKit

public class GeneralHelper {
    
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
    
    public static var UniversalSafeOffsets = UIApplication.shared.windows.first?.safeAreaInsets
    
  public static func uniq<S : Sequence, T : Equatable >(source: S) -> [T] where S.Iterator.Element == T {
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
#endif
