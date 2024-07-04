//
//  MainCollectionViewCell.swift
//  Reminder Project
//
//  Created by dopamint on 7/4/24.
//

import UIKit

import SnapKit
import Then

class MainCollectionViewCell: BaseCollectionViewCell {
    
    let iconView = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.height / 2
        $0.clipsToBounds = true
        $0.image = UIImage(systemName: "star")
    }
    let titleLabel = UILabel().then {
        $0.textColor = .gray
        $0.font = Font.bold15
        $0.text = "오늘"
    }
    let todoCountLabel = UILabel().then {
        $0.font = Font.bold20
        $0.text = "1"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(todoCountLabel)
    }
    
    override func configureLayout() {
        iconView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.height.width.equalTo(25)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView)
            make.top.equalTo(iconView.snp.bottom).offset(10)
        }
        todoCountLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
        }
    }
}


extension MainCollectionViewCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 1.0
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
                self.alpha = 0.5
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
                self.alpha = 1.0
            }
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
                self.alpha = 1.0
            }
        }
    }
}
