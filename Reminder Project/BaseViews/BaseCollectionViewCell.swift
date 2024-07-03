//
//  BaseCollectionViewCell.swift
//  Reminder Project
//
//  Created by dopamint on 7/2/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero )
        configureHierarchy()
        configureLayout()
        configureView()
        layer.cornerRadius = 15
        clipsToBounds = true
        backgroundColor = #colorLiteral(red: 0.1098036841, green: 0.1098041013, blue: 0.1183908954, alpha: 1)
    }
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {}
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
