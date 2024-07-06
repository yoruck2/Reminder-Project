//
//  TodoListTableRepository.swift
//  Reminder Project
//
//  Created by dopamint on 7/5/24.
//

import Foundation
import RealmSwift

class TodoListTableRepository {
    
    static let shared = TodoListTableRepository()
    private init() {
        print(realm.configuration.fileURL ?? "")
    }
    
    let realm = try! Realm()
    lazy var todoListTable = realm.objects(TodoListTable.self)
    
    // MARK: CRUD -
    func createItem(_ data: TodoListTable) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("데이터 불러오기 실패")
        }
    }
    func  updateItem(_ data: TodoListTable, handler: (() -> Void)) {
        try! realm.write {
            realm.add(data)
            handler()
        }
    }
    func deleteItem(data: TodoListTable) {
        try! realm.write {
            realm.delete(data)
        }
    }
    
    // MARK: 정렬 -
    func sortbyName() -> Results<TodoListTable> {
        let value = todoListTable.sorted(byKeyPath: "name", ascending: true)
        return value
    }
    func sortbyDeadline() -> Results<TodoListTable> {
        let value = todoListTable.sorted(byKeyPath: "deadline", ascending: true)
        return value
    }
    // MARK: 목록 불러오기 -
    
    // TODO: 아무 조건 안달면 어떻게 정렬? -> id로 정렬 (생성순)
    func fetchAll() -> Results<TodoListTable> {
        let value = todoListTable
        return value
    }
    func fetchToday() -> Results<TodoListTable> {
        let value = todoListTable.where {
            $0.deadline == Date().toString.toDate && $0.isDone == false
        }
        return value
    }
    func fetchScheduled() -> Results<TodoListTable> {
        let value = todoListTable.where {
            $0.deadline > Date().toString.toDate && $0.deadline != nil && $0.isDone == false
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
}
