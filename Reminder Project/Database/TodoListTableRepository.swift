//
//  TodoListTableRepository.swift
//  Reminder Project
//
//  Created by dopamint on 7/5/24.
//

import Foundation
import RealmSwift

class TodoListTableRepository {
    
    let realm = try! Realm()
    lazy var todoListTable = realm.objects(TodoListTable.self)
    
    func createItem(_ data: TodoListTable) {
        do {
            try realm.write {
                realm.add(data)
                print("Realm Create Succeed")
            }
        } catch {
            print("데이터 불러오기 실패")
        }
    }
    func fetchAll() -> Results<TodoListTable> {
        let value = todoListTable
        return value
    }
    
    func sortbyName() -> Results<TodoListTable> {
        let value = todoListTable.sorted(byKeyPath: "name", ascending: true)
        return value
    }
    
    func sortbyDeadline() -> Results<TodoListTable> {
        let value = todoListTable.sorted(byKeyPath: "deadline", ascending: true)
        return value
    }
    
    func fetchToday() -> Results<TodoListTable> {
        let value = todoListTable.where {
            $0.deadline == Date().toString
        }
        return value
    }
    func fetchScheduled() -> Results<TodoListTable> {
        let value = todoListTable.where {
            $0.deadline != Date().toString && $0.deadline != ""
        }
        return value
    }
    func fetchFlaged() -> Results<TodoListTable> {
        let value = todoListTable.where {
            $0.isflaged == true
        }
        return value
    }
    func fetchDone() -> Results<TodoListTable> {
        let value = todoListTable.where {
            $0.isDone == true
        }
        return value
    }

    
    func deleteItem(data: TodoListTable) {
        try! realm.write {
            realm.delete(data)
        }
    }
}

