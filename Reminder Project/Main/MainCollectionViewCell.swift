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
    
    let backView = UIView()
    
    let iconView = UIImageView().then {
        $0.contentMode = .center
        $0.tintColor = .white
    }
    let titleLabel = UILabel().then {
        $0.textColor = .gray
        $0.font = Font.bold15
    }
    let todoCountLabel = UILabel().then {
        $0.font = Font.bold20
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(todoCountLabel)
    }
    
    override func configureLayout() {
        
        backView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.height.equalTo(35)
            make.width.equalTo(35)
        }
        iconView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView).offset(2)
            make.top.equalTo(iconView.snp.bottom).offset(10)
        }
        todoCountLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
        }
    }
    override func draw(_ rect: CGRect) {
        backView.layer.cornerRadius = backView.bounds.width / 2
        backView.clipsToBounds = true
    }
    func setUpCellData(category: ListCategory, count: Int?) {
        let attribute = category.attribute
        iconView.image = attribute.symbolImage
        titleLabel.text = attribute.title
        todoCountLabel.text = count?.formatted() ?? ""
        backView.backgroundColor = attribute.color
        
    }
}
