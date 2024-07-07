//
//  AddNewTodo.swift
//  Reminder Project
//
//  Created by dopamint on 7/2/24.
//

import UIKit
import PhotosUI

import SnapKit
import Then
import Toast


enum EditType {
    case add
    case update
}

final class TodoEditorViewController: BaseViewController<AddNewTodoView> {
    
    let editType: EditType
    var todoData: TodoListTable = TodoListTable() {
        didSet {
            updateTodaData()
        }
    }
    
    var date = Date()
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: .reloadCollectionView,
                                        object: nil,
                                        userInfo: nil)
        NotificationCenter.default.post(name: .reloadTableView,
                                        object: nil,
                                        userInfo: nil)
    }
    
    init(_ editType: EditType) {
        self.editType = editType
        super.init(nibName: .none, bundle: .none)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRootView()
    }
    
    func configureRootView() {
        rootView.backgroundColor = #colorLiteral(red: 0.1098036841, green: 0.1098041013, blue: 0.1183908954, alpha: 1)
        rootView.deadlineButton.delegate = self
        rootView.tagEditButton.delegate = self
        rootView.priorityEditButton.delegate = self
        rootView.imageEditButton.delegate = self
        
    }
    func updateTodaData() {
        print(todoData)
        rootView.nameTextField.text = todoData.name
        rootView.memoTextField.text = todoData.memo
        rootView.deadlineButton.setValueLabel.text = todoData.deadline?.toString
        rootView.tagEditButton.setValueLabel.text = todoData.tag
        rootView.priorityEditButton.setValueLabel.text = todoData.priority
        
        rootView.imageView.image = FileManager.loadImageToDocument(filename: "\(todoData.id)")
    }
    
    // TODO: 추가 <-> 확인 분기처리
    override func configureView() {
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
        if editType == .update {
            add.title = "확인"
        }
        navigationItem.rightBarButtonItem = add
    }
    
    @objc
    func cancelButtonTapped() {
        dismiss(animated: true)
    }
    @objc
    func addButtonTapped() {
        guard let title = rootView.nameTextField.text, !title.isEmpty else {
            self.view.makeToast("제목을 입력해주세요!")
            return
        }
        
        // TODO: 사진이 안뜨는 문제
        switch editType {
        case .add:
            todoData = TodoListTable(name: rootView.nameTextField.text!,
                                     memo: rootView.memoTextField.text!,
                                     deadline: date.toString.toDate ?? Date(),
                                     tag: rootView.tagEditButton.setValueLabel.text ?? "",
                                     priority: rootView.priorityEditButton.setValueLabel.text ?? "")
            repository.createItem(todoData) { [self] in
                dismiss(animated: true)
                if let image = rootView.imageView.image {
                    print(todoData.id, "이건 add")
                    FileManager.saveImageToDocument(image: image, filename: "\(todoData.id)")
                }
            }
        case .update:
            repository.createItem(todoData) { [self] in
                todoData.name = rootView.nameTextField.text ?? ""
                todoData.memo = rootView.memoTextField.text
                todoData.tag = rootView.tagEditButton.setValueLabel.text
                todoData.deadline = rootView.deadlineButton.setValueLabel.text?.toDate
                todoData.priority = rootView.priorityEditButton.setValueLabel.text
                
                dismiss(animated: true)
                if let image = rootView.imageView.image {
                    print(todoData.id, "이건 update")
                    FileManager.saveImageToDocument(image: image, filename: "\(todoData.id)")
                }
            }
        }
    }
}

extension TodoEditorViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.rootView.imageView.image = image as? UIImage
                }
            }
        }
    }
}

extension TodoEditorViewController: EditButtonViewDelegate {
    func editButtonTapped(button: EditButton) {
        switch button {
        case .deadline:
            presentDateSheetView()
        case .tag:
            let nextVC = TagViewController()
            let tagValue = self.rootView.tagEditButton.setValueLabel
            nextVC.tagHandler = { value in
                if value != "" {
                    let trimmedText = value.trimmingCharacters(in: ["#"])
                    tagValue.text = "#\(trimmedText)"
                }
            }
            nextVC.tagTextField.text = tagValue.text?.trimmingCharacters(in: ["#"])
            navigationController?.pushViewController(nextVC, animated: true)
        case .priority:
            let nextVC = PriorityViewController()
            let priorityValue = (self.rootView.priorityEditButton.setValueLabel.text?.toPriority ?? 0) - 1
            nextVC.priorityHandler = { value in
                self.rootView.priorityEditButton.setValueLabel.text = "\(value)"
            }
            
            nextVC.prioritySegmentControl.selectedSegmentIndex = abs(priorityValue)
            navigationController?.pushViewController(nextVC, animated: true)
        case .addImage:
            var configuration = PHPickerConfiguration()
            configuration.filter = .any(of: [.images])
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func presentDateSheetView() {
        let nextVC = DateViewController()
        if let sheet = nextVC.sheetPresentationController {
            sheet.detents = [ .custom(resolver: {
                context in
                return 280
            })]
        }
        nextVC.delegate = self
        nextVC.dateHandler = { value in
            self.date = value
            self.rootView.deadlineButton.setValueLabel.text = value.toString
        }
        nextVC.datePicker.date = self.date
        present(nextVC, animated: true)
    }
}
