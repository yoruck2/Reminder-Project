//
//  PriorityViewModel.swift
//  Reminder Project
//
//  Created by dopamint on 7/10/24.
//

import Foundation

class PriorityViewModel {
    var inputPriority = Observable(Int())
    var outputPriority = Observable("")
    
    init() {
        inputPriority.bind { _ in
            self.transform()
        }
    }
    
    func transform() {
        switch inputPriority.value {
        case 0:
            outputPriority.value = "!!!"
        case 1:
            outputPriority.value = "!!"
        case 2:
            outputPriority.value = "!"
        default:
            break
        }
    }
}
