//
//  ListCategory.swift
//  Reminder Project
//
//  Created by dopamint on 7/4/24.
//

import UIKit

enum ListCategory: CaseIterable {
    case today
    case scheduled
    case all
    case flagged
    case done
    case custom
    
    var attribute: (symbolImage: UIImage?, color: UIColor, title: String) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .large)
        switch self {
            
        case .today:
            return (symbolImage: UIImage(systemName: "calendar", withConfiguration: largeConfig), color: .systemBlue, title: "오늘")
        case .scheduled:
            return (symbolImage: UIImage(systemName: "calendar", withConfiguration: largeConfig), color: .systemRed, title: "예정")
        case .all:
            return (symbolImage: UIImage(systemName: "tray.fill", withConfiguration: largeConfig), color: .darkGray, title: "전체")
        case .flagged:
            return (symbolImage: UIImage(systemName: "flag.fill", withConfiguration: largeConfig), color: .systemOrange, title: "깃발 표시")
        case .done:
            return (symbolImage: UIImage(systemName: "checkmark", withConfiguration: largeConfig), color: .systemGreen, title: "완료됨")
        case .custom:
            return (symbolImage: UIImage(systemName: "list.bullet", withConfiguration: largeConfig), color: .systemBlue, title: "")
        }
    }
}
