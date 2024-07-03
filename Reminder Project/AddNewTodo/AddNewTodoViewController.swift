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
import PhotosUI

final class AddNewTodoViewController: BaseViewController {
    
    private let nameTextField = UITextField().then {
        $0.placeholder = "제목"
    }
    private let separartorLine = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0.2156859636, green: 0.2156865597, blue: 0.2285700738, alpha: 1)
    }
    private let memoTextField = UITextField().then {
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
    
    private lazy var deadlineButton = EditButtonView(type: .deadline).then {
        $0.delegate = self
    }
    private lazy var tagEditButton = EditButtonView(type: .tag).then {
        $0.delegate = self
        $0.tintColor = .systemBlue
    }
    private lazy var priorityEditButton = EditButtonView(type: .priority).then {
        $0.delegate = self
    }
    private lazy var imageEditButton = EditButtonView(type: .addImage).then {
        $0.delegate = self
    }
    
    private var imageView = UIImageView()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("dissmisAddNewTodo"),
                                        object: nil,
                                        userInfo: nil)
    }
    
    override func configureHierarchy() {
        view.addSubview(textFieldStackView)
        view.addSubview(deadlineButton)
        view.addSubview(tagEditButton)
        view.addSubview(priorityEditButton)
        view.addSubview(imageEditButton)
        view.addSubview(imageView)
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
        deadlineButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(textFieldStackView.snp.bottom).offset(20)
            make.height.equalTo(textFieldStackView).multipliedBy(0.3)
        }
        tagEditButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(deadlineButton.snp.bottom).offset(20)
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
        imageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(imageEditButton)
            make.trailing.equalTo(imageEditButton.disclosureIndicator.snp.leading)
            make.width.equalTo(imageView.snp.height)
        }
    }
    
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
        navigationItem.leftBarButtonItem = cancel
        navigationItem.rightBarButtonItem = add
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
                                 deadline: deadlineButton.titleLabel.text!)
        
        try! realm.write {
            realm.add(data)
            dismiss(animated: true) {
            }
        }
    }
}

extension AddNewTodoViewController: EditButtonViewDelegate, PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.imageView.image = image as? UIImage
                }
            }
        }
    }
    
    func editButtonTapped(button: EditButton) {
        switch button {
        case .deadline:
            presentSheetView()
        case .tag:
            let nextVC = TagViewController()
            nextVC.tagHandler = { value in
                self.tagEditButton.titleLabel.text = "태그    #\(value)"
            }
            navigationController?.pushViewController(nextVC, animated: true)
        case .priority:
            let nextVC = PriorityViewController()
            nextVC.priorityHandler = { value in
                self.priorityEditButton.titleLabel.text = "우선 순위    \(value)"
            }
            navigationController?.pushViewController(nextVC, animated: true)
        case .addImage:
            var configuration = PHPickerConfiguration()
            configuration.filter = .any(of: [.images])
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            
        }
    }
    
    func presentSheetView() {
        let nextVC = DateViewController()
        if let sheet = nextVC.sheetPresentationController {
            sheet.detents = [ .custom(resolver: {
                context in
                return 280
            })]
        }
        nextVC.delegate = self
        nextVC.dateHandler = { value in
            self.deadlineButton.titleLabel.text = "마감일    \(value.toString)"
        }
        present(nextVC, animated: true)
    }
}

