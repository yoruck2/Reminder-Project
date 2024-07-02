//
//  AddNewTodo.swift
//  Reminder Project
//
//  Created by dopamint on 7/2/24.
//

import UIKit

import RealmSwift
import SnapKit
import Then
import Toast

protocol AddNewTodoViewControllerDelegate: AnyObject {
    func dismissAddNewTodoViewController()
}

class AddNewTodoViewController: BaseViewController {
    
    weak var delegate: AddNewTodoViewControllerDelegate?
    
    let nameTextField = UITextField().then {
        $0.placeholder = "제목"
    }
    let separartorLine = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0.2156859636, green: 0.2156865597, blue: 0.2285700738, alpha: 1)
    }
    let memoTextField = UITextField().then {
        $0.placeholder = "메모"
    }
    lazy var textFieldStackView = UIStackView().then {
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
    
    let deadlineTextField = UITextField().then {
        $0.placeholder = "마감일"
        $0.backgroundColor = #colorLiteral(red: 0.1725487709, green: 0.1725491583, blue: 0.1811430752, alpha: 1)
    }
    let tagEditButton = EditButtonView().then {
        $0.text = "  태그"
    }
    let priorityEditButton = EditButtonView().then {
        $0.text = "  우선 순위"
    }
    let imageEditButton = EditButtonView().then {
        $0.text = "  이미지 추가"
    }
    
    override func configureHierarchy() {
        view.addSubview(textFieldStackView)
        view.addSubview(deadlineTextField)
        view.addSubview(tagEditButton)
        view.addSubview(priorityEditButton)
        view.addSubview(imageEditButton)
    }
    
    override func configureLayout() {
        
        nameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        separartorLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        memoTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
        }
        textFieldStackView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.24)
        }
        
        deadlineTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(textFieldStackView.snp.bottom).offset(20)
            make.height.equalTo(textFieldStackView).multipliedBy(0.3)
        }
        
        tagEditButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(deadlineTextField.snp.bottom).offset(20)
            make.height.equalTo(textFieldStackView).multipliedBy(0.3)
        }
        priorityEditButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(tagEditButton.snp.bottom).offset(20)
            make.height.equalTo(textFieldStackView).multipliedBy(0.3)
        }
        
        imageEditButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(priorityEditButton.snp.bottom).offset(20)
            make.height.equalTo(textFieldStackView).multipliedBy(0.3)
        }
        
        
    }
    
    // TODO: 메서드로 만들고 싶은데.. 셀렉터 떔에 안됨
    override func configureView() {
        view.backgroundColor = #colorLiteral(red: 0.1098036841, green: 0.1098041013, blue: 0.1183908954, alpha: 1)
        navigationItem.title = "새로운 할 일"
        navigationItem.titleView?.tintColor = .white
        let cancel = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped))
        let add = UIBarButtonItem(
            title: "추가",
            style: .plain,
            target: self,
            action: #selector(addButtonTapped))
        navigationItem.leftBarButtonItems = [cancel]
        navigationItem.rightBarButtonItems = [add]
    }
    
    @objc
    func cancelButtonTapped() {
        dismiss(animated: true)
    }
    @objc
    func addButtonTapped() {
        guard let title = nameTextField.text, !title.isEmpty else {
            self.view.makeToast("제목을 입력해주세요!")
            return
        }
        let realm = try! Realm()
        let data = TodoListTable(name: nameTextField.text!,
                                 memo: memoTextField.text!,
                                 deadline: deadlineTextField.text!)
        
        try! realm.write {
            
            realm.add(data)
            dismiss(animated: true) {
                self.delegate?.dismissAddNewTodoViewController()
            }
        }
    }
}
