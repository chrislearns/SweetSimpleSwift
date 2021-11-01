//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 11/1/21.
//

import SwiftUI

public enum PasswordRequirements: String {
    case oneUppercase = "(?=.*[A-Z])"
    case oneLowercase = "(?=.*[a-z])"
    case oneDigit = "(?=.*[0-9])"
}
