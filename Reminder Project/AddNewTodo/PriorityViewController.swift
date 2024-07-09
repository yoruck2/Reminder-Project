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
    
    private let viewModel = PriorityViewModel()
    lazy var prioritySegmentControl = UISegmentedControl(items: ["상", "중", "하"]).then {
        $0.selectedSegmentIndex = viewModel.inputPriority.value
        $0.addTarget(self, action: #selector(segmentSelected), for: .valueChanged)
    }
    
    @objc
    func segmentSelected() {
        viewModel.inputPriority.value = prioritySegmentControl.selectedSegmentIndex
    }
    
    let priorityLabel = UILabel().then {
        $0.text = ""
        $0.font = .boldSystemFont(ofSize: 30)
        $0.textColor = .white
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
        bindData()
    }
    
    func bindData() {
        viewModel.outputPriority.bind { value in
            self.priorityLabel.text = value
        }
        
        
    }
    
    func configureHierarchy() {
        view.addSubview(prioritySegmentControl)
        view.addSubview(priorityLabel)
    }
    
    func configureLayout() {
        prioritySegmentControl.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(20)
        }
        priorityLabel.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        navigationItem.title = "우선 순위"
        view.backgroundColor = #colorLiteral(red: 0.1725487709, green: 0.1725491583, blue: 0.1811430752, alpha: 1)
    }
}
