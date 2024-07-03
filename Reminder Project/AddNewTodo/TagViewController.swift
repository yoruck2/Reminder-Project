//
//  File.swift
//  Reminder Project
//
//  Created by dopamint on 7/4/24.
//

import UIKit

import SnapKit
import Then

class TagViewController: BaseViewController {
    
    let tagTextField = UITextField().then {
        $0.backgroundColor = .darkGray
    }
    var tagHandler: ((String) -> Void)?
    
    
    override func viewWillDisappear(_ animated: Bool) {
        tagHandler?(tagTextField.text ?? "")
    }

    override func configureHierarchy() {
        view.addSubview(tagTextField)
    }
    
    override func configureLayout() {
        tagTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(30)
        }
    }
    
    override func configureView() {
        navigationItem.title = "태그"
    }
}
