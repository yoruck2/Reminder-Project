//
//  String+.swift
//  Reminder Project
//
//  Created by dopamint on 7/5/24.
//

import Foundation

extension String {
    var toDate: Date? {
        let birthdayFormatStyle = Date.FormatStyle()
            .year(.defaultDigits)
            .month(.twoDigits)
            .day(.twoDigits)
            .weekday(.abbreviated)
            .locale(Locale(identifier: "ko_KR"))
        return try? birthdayFormatStyle.parse(self)
    }

    var toPriority: Int {
        switch self{
        case "상":
            return 1
        case "중":
            return 2
        case "하":
            return 3
        default:
            return 4
        }
    }
}
