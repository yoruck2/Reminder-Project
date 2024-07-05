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
    @Persisted var deadline: String?
    @Persisted var tag: String?
    @Persisted var priority: Int?
    @Persisted var isflaged: Bool
    @Persisted var isDone: Bool
    
    
    convenience init(name: String,
                     memo: String,
                     deadline: String,
                     tag: String,
                     priority: Int,
                     isflaged: Bool = false,
                     isDone: Bool = false) {
        self.init()
        self.name = name
        self.memo = memo
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
    }
}
