//
//  ListCategory.swift
//  Reminder Project
//
//  Created by dopamint on 7/4/24.
//

import UIKit

enum ListCategory: CaseIterable {
    case Today
    case Scheduled
    case All
    case Flaged
    case Done
    
    var attribute: (symbolImage: UIImage?, color: UIColor, title: String) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .large)
        switch self {
            
        case .Today:
            return (symbolImage: UIImage(systemName: "calendar", withConfiguration: largeConfig), color: .systemBlue, title: "오늘")
        case .Scheduled:
            return (symbolImage: UIImage(systemName: "calendar", withConfiguration: largeConfig), color: .systemRed, title: "예정")
        case .All:
            return (symbolImage: UIImage(systemName: "tray.fill", withConfiguration: largeConfig), color: .darkGray, title: "전체")
        case .Flaged:
            return (symbolImage: UIImage(systemName: "flag.fill", withConfiguration: largeConfig), color: .systemYellow, title: "깃발 표시")
        case .Done:
            return (symbolImage: UIImage(systemName: "checkmark", withConfiguration: largeConfig), color: .systemGreen, title: "완료됨")
        }
    }
}
