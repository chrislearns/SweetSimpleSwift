//
//  SwiftUIView.swift
//  
//
//  Created by Chris Guirguis on 10/6/21.
//

import SwiftUI

extension String {
    func nsattributedString(attributes: [NSAttributedString.Key : Any]? = nil) -> NSAttributedString {
        .init(string: self, attributes: attributes)
    }
}
