//
//  TodoListTable.swift
//  Reminder Project
//
//  Created by dopamint on 7/2/24.
//

import RealmSwift
import Foundation

class Category: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var todolist: List<TodoListTable>
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

class TodoListTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var memo: String?
    @Persisted var deadline: Date?
    @Persisted var tag: String?
    @Persisted var priority: String?
    @Persisted var isFlagged: Bool
    @Persisted var isDone: Bool
    
    @Persisted(originProperty: "todolist") var customCategoty: LinkingObjects<Category>
    
    convenience init(name: String,
                     memo: String,
                     deadline: Date,
                     tag: String,
                     priority: String,
                     isflagged: Bool = false,
                     isDone: Bool = false) {
        self.init()
        self.name = name
        self.memo = memo
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
    }
}
