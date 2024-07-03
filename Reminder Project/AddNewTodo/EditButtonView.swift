//
//  EditButtonView.swift
//  Reminder Project
//
//  Created by dopamint on 7/2/24.
//

import UIKit

import SnapKit
import Then

enum EditButton: String {
    case deadline = "마감일"
    case tag = "태그"
    case priority = "우선 순위"
    case addImage = "이미지 추가"
}

final class EditButtonView: BaseView {
    
    var titleLabel = UILabel()
    var disclosureIndicator = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
    }
    
    init(type: EditButton) {
        super.init(frame: .zero)
        
        backgroundColor = #colorLiteral(red: 0.1725487709, green: 0.1725491583, blue: 0.1811430752, alpha: 1)
        layer.cornerRadius = 15
        clipsToBounds = true
        titleLabel.text = type.rawValue
    }
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(disclosureIndicator)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalTo(disclosureIndicator.snp.leading).offset(-5)
            make.centerY.equalToSuperview()
        }
        disclosureIndicator.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.width.equalTo(15)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
    }
    
}
