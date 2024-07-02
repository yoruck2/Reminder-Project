//
//  TodoListTableViewCell.swift
//  Reminder Project
//
//  Created by dopamint on 7/2/24.
//

import UIKit

final class TodoListTableViewCell: BaseTableViewCell {
    
    var todoData: TodoListTable? = nil {
        didSet {
            configureView()
        }
    }
    
    private var todoCheckButton = UIButton().then {
        $0.setImage(UIImage(systemName: "circle"), for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        $0.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .highlighted)
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
    
    override func configureHierarchy() {
        contentView.addSubview(todoCheckButton)
        contentView.addSubview(todoNameLabel)
        contentView.addSubview(todoMemoLabel)
        contentView.addSubview(deadlineLabel)
    }
    override func configureLayout() {
        backgroundColor = .black
        todoCheckButton.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        todoNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(todoCheckButton.snp.trailing).offset(10)
            make.top.equalTo(todoCheckButton)
        }
        todoMemoLabel.snp.makeConstraints { make in
            make.leading.equalTo(todoNameLabel)
            make.top.equalTo(todoNameLabel.snp.bottom).offset(5)
        }
        deadlineLabel.snp.makeConstraints { make in
            make.leading.equalTo(todoMemoLabel)
            make.top.equalTo(todoMemoLabel.snp.bottom).offset(5)
        }
    }
    override func configureView() {
        guard let todoData else {
            return
        }
        todoCheckButton.isSelected = todoData.isDone
        todoNameLabel.text = todoData.name
        todoMemoLabel.text = todoData.memo
        deadlineLabel.text = todoData.deadline
    }
}

// MARK: Date -
//extension DateFormatter {
//    static let krDateFormatter : DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.locale = .init(identifier: "ko_KR")
//    return formatter
//    }()
//}

//class MyDateFormatter {
//    static let shared = MyDateFormatter()
//
//    private init(){}
//
//    private var dotDateFormatter: DateFormatter {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale.current
//        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
//        return dateFormatter
//    }
//
//
//    func dotDateString(from date: Date) -> String{
//        calendarDateFormatter.string(from: date)
//    }
//
//}
