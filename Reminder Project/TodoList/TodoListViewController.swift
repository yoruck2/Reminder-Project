//
//  TodoListViewController.swift
//  Reminder Project
//
//  Created by dopamint on 7/2/24.
//

import UIKit

final class TodoListViewController: BaseViewController<TodoListView> {
    
    let listCategory: ListCategory?
    lazy var todoList = repository.todoListTable {
        didSet {
            // MARK: 정렬이 바뀔때 실행 -
            rootView.todoListTableView.reloadData()
        }
    }
    
    init(listCategory: ListCategory?) {
        self.listCategory = listCategory
        super.init(nibName: "", bundle: .none)
        
        switch self.listCategory {
        case .today:
            rootView.todoTitleLabel.text = "오늘"
            todoList = repository.fetchToday()
        case .scheduled:
            rootView.todoTitleLabel.text = "예정"
            todoList = repository.fetchScheduled()
        case .all:
            rootView.todoTitleLabel.text = "전체"
            todoList = repository.fetchAll()
        case .flaged:
            rootView.todoTitleLabel.text = "깃발 표시"
            todoList = repository.fetchFlaged()
        case .done:
            rootView.todoTitleLabel.text = "완료됨"
            todoList = repository.fetchDone()
        case .none:
            return
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: 이거 하면 정렬 기능이 안먹는다.. 이유는?
//    lazy var todoList = self.rootView.todoList!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTableView),
                                               name: .reloadTableView,
                                               object: nil)
    }
    @objc func reloadTableView(_ notification: Notification) {
        DispatchQueue.main.async {
            self.rootView.todoListTableView.reloadData()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: .reloadCollectionView,
                                        object: nil,
                                        userInfo: nil)
    }
    
    override func configureView() {
        
        configureNavigationBar()
        configureTableView()
        rootView.handler = {
            let nextVC = UINavigationController(rootViewController: TodoEditorViewController(.add))
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = TodoEditorViewController(.update)
        nextVC.todoData = todoList[indexPath.row]
        present(UINavigationController(rootViewController: nextVC), animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let sweptCell = tableView.cellForRow(at: indexPath) as! TodoListTableViewCell
        let delete = UIContextualAction(style: .destructive, title: .none) { [self] (UIContextualAction,
                                                                                     UIView,
                                                                                     success: @escaping (Bool) -> Void) in
            repository.deleteItem(data: todoList[indexPath.row])
            success(true)
            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        }
        let flag = UIContextualAction(style: .normal, title: .none) { [self] (UIContextualAction,
                                                                              UIView,
                                                                              success: @escaping (Bool) -> Void) in
            repository.toggleFlag(data: todoList[indexPath.row])
            success(true)
            if listCategory == .flaged {
                tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
            } else {
                tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
            }
        }
        
        if sweptCell.todoData?.isFlaged == true {
            print("트루")
            flag.image = UIImage(systemName: "flag.fill")
        } else {
            print("폴스")
            flag.image = UIImage(systemName: "flag")
        }
        delete.backgroundColor = .systemRed
        flag.backgroundColor = .systemOrange
        delete.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions:[delete, flag])
    }
}
