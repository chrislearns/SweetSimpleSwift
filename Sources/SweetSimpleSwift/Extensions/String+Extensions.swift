//
//  SwiftUIView.swift
//  
//
//  Created by Chris Guirguis on 10/6/21.
//

#if os(iOS)

import SwiftUI

public extension String {
    public func nsattributedString(attributes: [NSAttributedString.Key : Any]? = nil) -> NSAttributedString {
        .init(string: self, attributes: attributes)
    }
    
    public func toText() -> Text {
        Text(self)
    }
  
  public func toSFSymbol() -> Image {
      Image(systemName: self)
  }
    
    public func toColor() -> Color? {
        Color(hex: self)
    }
    
    public var isValidEmail: Bool {
         
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do {
            let regularExpression = try NSRegularExpression(pattern: emailRegEx, options: .caseInsensitive)
            return regularExpression.firstMatch(in: self, options: [], range: NSMakeRange(0, utf16.count)) != nil
        } catch let error {
            print (error.localizedDescription)
            return false
        }
    }
    
    public var isValidPhone: Bool {
            let phoneRegEx = "^\\(?([0-9]{3})\\)?[-.●]?([0-9]{3})[-.●]?([0-9]{4})$"
        do {
            let regularExpression = try NSRegularExpression(pattern: phoneRegEx, options: .caseInsensitive)
            return regularExpression.firstMatch(in: self, options: [], range: NSMakeRange(0, utf16.count)) != nil
        } catch let error {
            print (error.localizedDescription)
            return false
        }
    }
    
    public func isValidPassword(minCharacters: Int, requirements: [PasswordRequirements] = [.oneDigit, .oneLowercase, .oneUppercase]) -> Bool {
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        
        let passwordRegEx = "\(requirements.map{$0.rawValue}.joined(separator: "")).{\(minCharacters),}"
        
        do {
            let regularExpression = try NSRegularExpression(pattern: passwordRegEx, options: .useUnixLineSeparators)
            return regularExpression.firstMatch(in: self, options: [], range: NSMakeRange(0, utf16.count)) != nil
        } catch let error {
            print (error.localizedDescription)
            return false
        }
    }

    
    /// **Force** is used to dictate if it should be added even if the last character is equal to the affix. Note it is irrelevant if the **affixValue** is more than 1 character large
    public func withAffix(_ affixValue: String, location: Affix, force: Bool = false) -> String {
        var currentAffix: String? {
            switch location {
            case .prefix:
                return self.first?.description
            case .suffix:
                return self.last?.description
            }
        }
        
        if currentAffix == affixValue && !force {
            return self
        }
        switch location {
        case .prefix:
            return affixValue + self
        case .suffix:
            return self + affixValue
        }
    }
}



#endif
