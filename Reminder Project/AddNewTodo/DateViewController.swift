//
//  DatePickerViewController.swift
//  Reminder Project
//
//  Created by dopamint on 7/3/24.
//

import UIKit

import SnapKit
import Then

final class DateViewController: UIViewController {
    
    var delegate: TodoEditorViewController?
    var dateHandler: ((Date) -> Void)?
    lazy var datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dateHandler?(datePicker.date)
    }
    
    func configureHierarchy() {
        view.addSubview(datePicker)
    }
    func configureLayout() {
        datePicker.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureView() {
        view.backgroundColor = #colorLiteral(red: 0.1725487709, green: 0.1725491583, blue: 0.1811430752, alpha: 1)
    }
}
