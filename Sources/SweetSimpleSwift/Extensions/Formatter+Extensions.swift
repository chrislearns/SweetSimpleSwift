//
//  SwiftUIView.swift
//  
//
//  Created by Chris Guirguis on 10/13/21.
//

import SwiftUI

public extension Formatter {
  static func iso8601withFractionalSeconds(timezone: TimeZone? = .init(secondsFromGMT: 0)) -> DateFormatter  {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
      formatter.timeZone = timezone
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }
}
