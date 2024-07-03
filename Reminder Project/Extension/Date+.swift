//
//  Date+.swift
//  Reminder Project
//
//  Created by dopamint on 7/4/24.
//

import Foundation

extension Date {
    var toString: String {
        let myFormat = Date.FormatStyle()
            .year(.defaultDigits)
            .month(.twoDigits)
            .day(.twoDigits)
            .locale(Locale(identifier: "ko_KR"))
        return self.formatted(myFormat)
    }
}
