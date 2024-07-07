//
//  String+.swift
//  Reminder Project
//
//  Created by dopamint on 7/5/24.
//

import UIKit

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
            return 3
        case "중":
            return 2
        case "하":
            return 1
        default:
            return 0
        }
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    func removeStrikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, 
                                        range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
