//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 12/21/21.
//

import SwiftUI

public extension Font {
    // from design document Helvetica Nueue was choosen
    static var customThinFont: String {"HelveticaNeue-Thin"}
    static var customLightFont: String {"HelveticaNeue-Light"}
    static var customRegularFont: String {"HelveticaNeue"}
    static var customMediumFont: String {"HelveticaNeue-Medium"}
    static var customBoldFont: String {"HelveticaNeue-Bold"}
        
    //MARK: thin weight fonts
    static var thinLarge: Font {.custom(customThinFont, size: .largeSize, relativeTo: .body)}
    static var thinMedium: Font {.custom(customThinFont, size: .mediumSize, relativeTo: .body)}
    static var thinSmall: Font {.custom(customThinFont, size: .smallSize, relativeTo: .body)}
    static var thinExtraSmall: Font {.custom(customThinFont, size: .extraSmallSize, relativeTo: .body)}
    static var thenExtraExtraSmall: Font {.custom(customThinFont, size: .extraExtraSmallSize, relativeTo: .body)}
    
    //MARK: light weight fonts
    static var lightLarge: Font {.custom(customLightFont, size: .largeSize, relativeTo: .body)}
    static var lightMedium: Font {.custom(customLightFont, size: .mediumSize, relativeTo: .body)}
    static var lightSmall: Font {.custom(customLightFont, size: .smallSize, relativeTo: .body)}
    static var lightExtraSmall: Font {.custom(customLightFont, size: .extraSmallSize, relativeTo: .body)}
    static var lightExtraExtraSmall: Font {.custom(customLightFont, size: .extraExtraSmallSize, relativeTo: .body)}
    
    //MARK: regular weight fonts
    static var regularLarge: Font {.custom(customRegularFont, size: .largeSize, relativeTo: .body)}
    static var regularMedium: Font {.custom(customRegularFont, size: .mediumSize, relativeTo: .body)}
    static var regularSmall: Font {.custom(customRegularFont, size: .smallSize, relativeTo: .body)}
    static var regularExtraSmall: Font {.custom(customRegularFont, size: .extraSmallSize, relativeTo: .body)}
    static var regularExtraExtraSmall: Font {.custom(customRegularFont, size: .extraExtraSmallSize, relativeTo: .body)}

    //MARK: semibold weight fonts
    static var semiboldLarge: Font {.custom(customMediumFont, size: .largeSize, relativeTo: .body)}
    static var semiboldMedium: Font {.custom(customMediumFont, size: .mediumSize, relativeTo: .body)}
    static var semiboldSmall: Font {.custom(customMediumFont, size: .smallSize, relativeTo: .body)}
    static var semiboldExtraSmall: Font {.custom(customMediumFont, size: .extraSmallSize, relativeTo: .body)}
    static var semiboldExtraExtraSmall: Font {.custom(customMediumFont, size: .extraExtraSmallSize, relativeTo: .body)}
    
    //MARK: bold weight fonts
    static var boldLarge: Font {.custom(customBoldFont, size: .largeSize, relativeTo: .body)}
    static var boldMedium: Font {.custom(customBoldFont, size: .mediumSize, relativeTo: .body)}
    static var boldSmall: Font {.custom(customBoldFont, size: .smallSize, relativeTo: .body)}
    static var boldExtraSmall: Font {.custom(customBoldFont, size: .extraSmallSize, relativeTo: .body)}
    static var boldExtraExtraSmall: Font {.custom(customBoldFont, size: .extraExtraSmallSize, relativeTo: .body)}
}
