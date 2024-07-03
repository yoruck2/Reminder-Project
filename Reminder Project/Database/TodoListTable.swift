//
//  TodoListTable.swift
//  Reminder Project
//
//  Created by dopamint on 7/2/24.
//

import RealmSwift

class TodoListTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var memo: String?
//    @Persisted var category: String?
    @Persisted var deadline: String?
    @Persisted var isDone: Bool
    
    
    convenience init(name: String,
                     memo: String,
//                     category: String,
                     deadline: String) {
        self.init()
        self.name = name
        self.memo = memo
//        self.category = category
        self.deadline = deadline
        self.isDone = false
    }
}
