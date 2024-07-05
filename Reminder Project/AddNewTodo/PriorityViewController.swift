//
//  PriorityViewController.swift
//  Reminder Project
//
//  Created by dopamint on 7/4/24.
//

import UIKit

import SnapKit
import Then

class PriorityViewController: UIViewController {
    
    let prioritySegmentControl = UISegmentedControl(items: ["상", "중", "하"]).then {
        $0.selectedSegmentIndex = 0
    }
    var priorityHandler: ((String) -> Void)?
    
    // TODO: Issue -> 선택 안하고 뒤로가면 앱 터지는 현상
    override func viewWillDisappear(_ animated: Bool) {
        let selectedIndex = prioritySegmentControl.selectedSegmentIndex
        priorityHandler?(prioritySegmentControl.titleForSegment(at: selectedIndex) ?? "" )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        view.addSubview(prioritySegmentControl)
    }
    
    func configureLayout() {
        prioritySegmentControl.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(20)
        }
    }
    
    func configureView() {
        navigationItem.title = "우선 순위"
        view.backgroundColor = #colorLiteral(red: 0.1725487709, green: 0.1725491583, blue: 0.1811430752, alpha: 1)
    }
}
