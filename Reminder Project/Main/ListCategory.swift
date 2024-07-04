//
//  ListCategory.swift
//  Reminder Project
//
//  Created by dopamint on 7/4/24.
//

import UIKit

enum ListCategory {
    case Today
    case Scheduled
    case All
    case Flaged
    case Done
    
    var attribute: (symbolImage: UIImage?, color: UIColor, title: String) {
            switch self {
            case .Today:
                return (symbolImage: UIImage(systemName: "calendar"), color: .systemBlue, title: "오늘")
            case .Scheduled:
                return (symbolImage: UIImage(systemName: "calendar"), color: .systemRed, title: "예정")
            case .All:
                return (symbolImage: UIImage(systemName: "tray.fill"), color: .darkGray, title: "전체")
            case .Flaged:
                return (symbolImage: UIImage(systemName: "flag.fill"), color: .systemYellow, title: "깃발 표시")
            case .Done:
                return (symbolImage: UIImage(systemName: "checkmark"), color: .systemGreen, title: "완료됨")
            }
        }
}
