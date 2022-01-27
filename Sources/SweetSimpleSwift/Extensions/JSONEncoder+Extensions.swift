//
//  SwiftUIView.swift
//  
//
//  Created by Chris Guirguis on 10/13/21.
//

import SwiftUI

public extension JSONEncoder.DateEncodingStrategy {
    static let iso8601withFractionalSeconds = custom {
        var container = $1.singleValueContainer()
        try container.encode(Formatter.iso8601withFractionalSeconds(timezone: TimeZone.current).string(from: $0))
    }
}
