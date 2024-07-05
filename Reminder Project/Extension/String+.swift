//
//  String+.swift
//  Reminder Project
//
//  Created by dopamint on 7/5/24.
//

import Foundation

extension String {
    
    var toPriority: Int {
        switch self{
        case "상":
            return 0
        case "중":
            return 1
        case "하":
            return 2
        default:
            return 0
        }
    }
}
