//
//  TodoListTableViewCell.swift
//  Reminder Project
//
//  Created by dopamint on 7/2/24.
//

import UIKit
import RealmSwift

final class TodoListTableViewCell: BaseTableViewCell {
    let repository = TodoListTableRepository.shared
    let realm = try! Realm()
    
    // TODO: 이건 repository로 어떻게 옮길지 고민
    var todoData: TodoListTable? = .none {
        didSet {
            configureView()
        }
    }
    
    private lazy var todoCheckButton = UIButton().then {
        $0.setImage(UIImage(systemName: "circle"), for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        $0.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .highlighted)
        $0.addTarget(self, action: #selector(todoCheckButtonTapped(_:)), for: .touchUpInside)
    }
    @objc
    func todoCheckButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        layoutSubviews()
        try? todoData?.realm?.write {
            if sender.isSelected {
                todoData?.isDone = true
            } else {
                todoData?.isDone = false
            }
            
        }
    }
    
    private lazy var priorityLabel = UILabel().then {
        if todoCheckButton.isSelected {
            $0.textColor = .red
        } else {
            $0.textColor = .white
        }
        $0.textColor = .systemBlue
    }
    private var todoNameLabel = UILabel().then {
        $0.textColor = .white
    }
    private var todoMemoLabel = UILabel().then {
        $0.textColor = .lightGray
    }
    private var deadlineLabel = UILabel().then {
        $0.textColor = .lightGray
    }
    private var tagLabel = UILabel().then {
        $0.textColor = .link
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if todoCheckButton.isSelected {
            [todoNameLabel, todoMemoLabel, deadlineLabel].forEach {
                $0.attributedText = $0.text?.strikeThrough()
            }
        } else {
            [todoNameLabel, todoMemoLabel, deadlineLabel].forEach {
                $0.attributedText = $0.text?.removeStrikeThrough()
            }
        }
    }
    
    override func configureHierarchy() {
        contentView.addSubview(priorityLabel)
        contentView.addSubview(todoCheckButton)
        contentView.addSubview(todoNameLabel)
        contentView.addSubview(todoMemoLabel)
        contentView.addSubview(deadlineLabel)
        contentView.addSubview(tagLabel)
    }
    override func configureLayout() {
        
        
        todoCheckButton.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        priorityLabel.snp.makeConstraints { make in
            make.leading.equalTo(todoCheckButton.snp.trailing).offset(10)
            make.top.equalTo(todoCheckButton)
        }
        todoNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(priorityLabel.snp.trailing)
            make.top.equalTo(priorityLabel)
        }
        todoMemoLabel.snp.makeConstraints { make in
            make.leading.equalTo(todoNameLabel)
            make.top.equalTo(todoNameLabel.snp.bottom).offset(5)
        }
        deadlineLabel.snp.makeConstraints { make in
            make.leading.equalTo(todoMemoLabel)
            make.top.equalTo(todoMemoLabel.snp.bottom).offset(5)
        }
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(deadlineLabel)
            make.leading.equalTo(deadlineLabel.snp.trailing)
        }
    }
    override func configureView() {
        backgroundColor = .black
        
        guard let todoData else {
            return
        }
        todoCheckButton.isSelected = todoData.isDone
        todoNameLabel.text = todoData.name
        todoMemoLabel.text = todoData.memo
        deadlineLabel.text = "\(todoData.deadline?.toString ?? "") "
        priorityLabel.text = "\(String(repeating: "!", count: todoData.priority ?? 0)) "
        if todoData.tag != "" {
            tagLabel.text = " \(todoData.tag ?? "")"
        }
    }
}
