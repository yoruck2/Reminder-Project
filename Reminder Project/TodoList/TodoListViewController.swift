//
//  TodoListViewController.swift
//  Reminder Project
//
//  Created by dopamint on 7/2/24.
//

import UIKit


final class TodoListViewController: BaseViewController {
    
    private let rootView = TodoListView()
    
    override func loadView() {
        view = rootView
    }

    override func configureView() {
        view.backgroundColor = .black
        configureNavigationBar()
        rootView.handler = {
            let addNewTodoVC = AddNewTodoViewController()
            let vc = UINavigationController(rootViewController: addNewTodoVC)
            self.present(vc, animated: true)
        }
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
            rootView.todoList = rootView.todoList.sorted(byKeyPath: "name", ascending: true)
        }
        let DeadlineSort = UIAction(title: "마감일 순서 정렬",
                                    image: UIImage(systemName: "calendar")) { [self] _ in
            rootView.todoList = rootView.todoList.sorted(byKeyPath: "deadline", ascending: true)
        }
        return UIMenu(children: [DeadlineSort, titleSort])
    }
}
