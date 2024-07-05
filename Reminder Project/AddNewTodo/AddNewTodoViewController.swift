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

final class AddNewTodoViewController: BaseViewController<AddNewTodoView> {
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("dissmisAddNewTodo"),
                                        object: nil,
                                        userInfo: nil)
    }
    
    override func configureView() {
        view.backgroundColor = #colorLiteral(red: 0.1098036841, green: 0.1098041013, blue: 0.1183908954, alpha: 1)
        rootView.deadlineButton.delegate = self
        rootView.tagEditButton.delegate = self
        rootView.priorityEditButton.delegate = self
        rootView.imageEditButton.delegate = self
        
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
        guard let title = rootView.nameTextField.text, !title.isEmpty else {
            self.view.makeToast("제목을 입력해주세요!")
            return
        }
        let realm = try! Realm()
        let data = TodoListTable(name: rootView.nameTextField.text!,
                                 memo: rootView.memoTextField.text!,
                                 deadline: rootView.deadlineButton.titleLabel.text!)
        try! realm.write {
            realm.add(data)
            dismiss(animated: true) {
            }
        }
    }
}

extension AddNewTodoViewController: PHPickerViewControllerDelegate {
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
            self.rootView.deadlineButton.titleLabel.text = "\(value.toString)"
        }
        present(nextVC, animated: true)
    }
}

extension AddNewTodoViewController: EditButtonViewDelegate {
    func editButtonTapped(button: EditButton) {
        switch button {
        case .deadline:
            presentSheetView()
        case .tag:
            let nextVC = TagViewController()
            nextVC.tagHandler = { value in
                self.rootView.tagEditButton.titleLabel.text = "태그    #\(value)"
            }
            navigationController?.pushViewController(nextVC, animated: true)
        case .priority:
            let nextVC = PriorityViewController()
            nextVC.priorityHandler = { value in
                self.rootView.priorityEditButton.titleLabel.text = "우선 순위    \(value)"
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
}
