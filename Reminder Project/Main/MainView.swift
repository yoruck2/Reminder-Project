//
//  MainView.swift
//  Reminder Project
//
//  Created by dopamint on 7/4/24.
//

import UIKit

class MainView: BaseView {
    
    var mainViewHandler: (() -> Void)?

    private let mainTitleLabel = UILabel().then {
        $0.text = "전체"
        $0.font = Font.bold30
        $0.textColor = .gray
    }
    
    lazy var mainCollectionView = UICollectionView(frame: .zero,
                                                   collectionViewLayout: UICollectionView.collectionViewLayout())

    private lazy var addNewTodoButton = UIButton().then {
        $0.setTitle(" 새로운 할 일", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        $0.addTarget(self, action: #selector(addNewTodoButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func addNewTodoButtonTapped() {
        mainViewHandler?()
    }
    
    let addNewListButton = UIButton().then {
        $0.setTitle("목록 추가", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    override func configureHierarchy() {
        addSubview(mainTitleLabel)
        addSubview(mainCollectionView)
        addSubview(addNewTodoButton)
        addSubview(addNewListButton)
    }
    
    override func configureLayout() {
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(safeAreaLayoutGuide).inset(20)
        }
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(addNewTodoButton.snp.top)
        }
        addNewTodoButton.snp.makeConstraints { make in
            make.leading.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.4)
        }
        addNewListButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.4)
        }
    }
}
