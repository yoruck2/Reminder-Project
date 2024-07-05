//
//  AddNewTodoView.swift
//  Reminder Project
//
//  Created by dopamint on 7/4/24.
//

import UIKit

import SnapKit
import Then

class AddNewTodoView: BaseView {
    
    let nameTextField = UITextField().then {
        $0.placeholder = "제목"
    }
    private let separartorLine = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0.2156859636, green: 0.2156865597, blue: 0.2285700738, alpha: 1)
    }
    let memoTextField = UITextField().then {
        $0.placeholder = "메모"
    }
    private lazy var textFieldStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 0
        $0.addArrangedSubview(nameTextField)
        $0.addArrangedSubview(separartorLine)
        $0.addArrangedSubview(memoTextField)
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.backgroundColor = #colorLiteral(red: 0.1725487709, green: 0.1725491583, blue: 0.1811430752, alpha: 1)
    }
    
    lazy var deadlineButton = EditButtonView(type: .deadline)
    lazy var tagEditButton = EditButtonView(type: .tag).then {
        $0.tintColor = .systemBlue
    }
    lazy var priorityEditButton = EditButtonView(type: .priority)
    lazy var imageEditButton = EditButtonView(type: .addImage)
    
    var imageView = UIImageView()
    
    override func configureHierarchy() {
        addSubview(textFieldStackView)
        addSubview(deadlineButton)
        addSubview(tagEditButton)
        addSubview(priorityEditButton)
        addSubview(imageEditButton)
        addSubview(imageView)
    }
    
    override func configureLayout() {
        nameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        separartorLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
        memoTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
        }
        textFieldStackView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.24)
        }
        deadlineButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.top.equalTo(textFieldStackView.snp.bottom).offset(20)
            make.height.equalTo(textFieldStackView).multipliedBy(0.3)
        }
        tagEditButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.top.equalTo(deadlineButton.snp.bottom).offset(20)
            make.height.equalTo(textFieldStackView).multipliedBy(0.3)
        }
        priorityEditButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.top.equalTo(tagEditButton.snp.bottom).offset(20)
            make.height.equalTo(textFieldStackView).multipliedBy(0.3)
        }
        imageEditButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.top.equalTo(priorityEditButton.snp.bottom).offset(20)
            make.height.equalTo(textFieldStackView).multipliedBy(0.3)
        }
        imageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(imageEditButton)
            make.trailing.equalTo(imageEditButton.disclosureIndicator.snp.leading)
            make.width.equalTo(imageView.snp.height)
        }
    }
}
