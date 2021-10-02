//
//  SwiftUIView.swift
//  
//
//  Created by Christopher Guirguis on 10/2/21.
//

import SwiftUI

extension Calendar {
    func monthFromMonthAndYear(month: Int, year: Int) -> Date? {
        date(from: .init(year: year, month: month, day: 1))
    }
    func monthFromDayAndMonthAndYear(month: Int, year: Int, day: Int) -> Date? {
        date(from: .init(year: year, month: month, day: day))
    }
}
