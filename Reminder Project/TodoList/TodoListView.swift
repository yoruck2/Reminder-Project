//
//  View.swift
//  Reminder Project
//
//  Created by dopamint on 7/2/24.
//

import UIKit
import SnapKit
import Then
import RealmSwift

final class TodoListView: BaseView {
    
    var handler: (() -> Void)?
    
    private let realm = try! Realm()
    var todoList: Results<TodoListTable>! {
        didSet {
            todoListTableView.reloadData()
        }
    }
    
    private let todoTitleLabel = UILabel().then {
        $0.text = "전체"
        $0.font = Font.bold30
        $0.textColor = .systemBlue
    }
    
    // TODO: estimated 왜않되.. ㅡ.ㅡ
    lazy var todoListTableView = UITableView().then {
        $0.backgroundColor = .black
        $0.delegate = self
        $0.dataSource = self
        $0.rowHeight = 100
        $0.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.id)
    }

    private lazy var addNewTodoButton = UIButton().then {
        $0.setTitle(" 새로운 할 일", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        $0.addTarget(self, action: #selector(addNewTodoButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func addNewTodoButtonTapped() {
        handler?()
    }
    
    override func configureHierarchy() {
        addSubview(todoTitleLabel)
        addSubview(todoListTableView)
        addSubview(addNewTodoButton)
    }
    
    override func configureLayout() {
        todoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(safeAreaLayoutGuide).inset(20)
        }
        todoListTableView.snp.makeConstraints { make in
            make.top.equalTo(todoTitleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(addNewTodoButton.snp.top)
        }
        addNewTodoButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.4)
        }
    }
    override func configureView() {
        todoList = realm.objects(TodoListTable.self)
        let realm = try! Realm()
        print(realm.configuration.fileURL)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didDismissNotification(_:)),
            name: NSNotification.Name("dissmisAddNewTodo"),
            object: nil
        )
        
    }
    @objc func didDismissNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.todoListTableView.reloadData()
        }
    }
}

extension TodoListView: UITableViewDelegate, UITableViewDataSource {
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
            
            try! realm.write {
                realm.delete(todoList[indexPath.row])
            }
            success(true)
            
            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        }
        delete.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions:[delete])
    }
}
