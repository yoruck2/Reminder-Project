//
//  ViewController.swift
//  Reminder Project
//
//  Created by dopamint on 7/2/24.
//

import UIKit

class BaseViewController<RootView: UIView>: UIViewController {
    let rootView = RootView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1725487709, green: 0.1725491583, blue: 0.1811430752, alpha: 1)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {}
}

