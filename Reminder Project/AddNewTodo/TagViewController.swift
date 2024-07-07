//
//  File.swift
//  Reminder Project
//
//  Created by dopamint on 7/4/24.
//

import UIKit

import SnapKit
import Then

class TagViewController: UIViewController {
    
    let tagTextField = UITextField().then {
        $0.backgroundColor = .darkGray
        $0.becomeFirstResponder()
    }
    var tagHandler: ((String) -> Void)?
    
    
    override func viewWillDisappear(_ animated: Bool) {
        tagHandler?(tagTextField.text ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        view.addSubview(tagTextField)
    }
    
    func configureLayout() {
        tagTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(30)
        }
    }
    
    func configureView() {
        navigationItem.title = "태그"
        view.backgroundColor = #colorLiteral(red: 0.1725487709, green: 0.1725491583, blue: 0.1811430752, alpha: 1)
    }
}
