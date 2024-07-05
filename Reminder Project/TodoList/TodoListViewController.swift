//
//  TodoListViewController.swift
//  Reminder Project
//
//  Created by dopamint on 7/2/24.
//

import UIKit
import RealmSwift

final class TodoListViewController: BaseViewController<TodoListView> {
    
    lazy var todoList = self.rootView.todoList!
    
    override func configureView() {
        view.backgroundColor = .black
        configureNavigationBar()
        configureTableView()
        rootView.handler = {
            let nextVC = UINavigationController(rootViewController: AddNewTodoViewController())
            self.present(nextVC, animated: true)
        }
    }
    
    private func configureTableView() {
        view.backgroundColor = .black
        configureNavigationBar()
        rootView.todoListTableView.delegate = self
        rootView.todoListTableView.dataSource = self
        rootView.todoListTableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.id)
        
    }
    private func configureNavigationBar() {
        let menu = configurePullDownButton()
        let menuButton = UIBarButtonItem(title: nil,
                                         image: UIImage(systemName: "ellipsis.circle"),
                                         target: nil,
                                         action: nil,
                                         menu: menu)
        navigationItem.rightBarButtonItem = menuButton
    }
    private func configurePullDownButton() -> UIMenu {
        let titleSort = UIAction(title: "제목 순서 정렬",
                                 image: UIImage(systemName: "abc")) { [self] _ in
            todoList = todoList.sorted(byKeyPath: "name", ascending: true)
        }
        let DeadlineSort = UIAction(title: "마감일 순서 정렬",
                                    image: UIImage(systemName: "calendar")) { [self] _ in
            todoList = todoList.sorted(byKeyPath: "deadline", ascending: true)
        }
        return UIMenu(children: [DeadlineSort, titleSort])
    }
}
extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.id, for: indexPath) as? TodoListTableViewCell
        else {
            return UITableViewCell()
        }
        cell.todoData = todoList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { [self] (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            
            try! rootView.realm.write {
                rootView.realm.delete(rootView.todoList[indexPath.row])
            }
            success(true)
            
            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        }
        delete.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions:[delete])
    }
}
