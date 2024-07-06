//
//  ViewController.swift
//  Reminder Project
//
//  Created by dopamint on 7/2/24.
//

import UIKit

class BaseViewController<RootView: UIView>: UIViewController {
    let rootView = RootView()
    let repository = TodoListTableRepository.shared
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {}
}

