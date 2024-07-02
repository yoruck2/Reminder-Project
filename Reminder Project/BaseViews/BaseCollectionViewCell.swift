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
    }
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {}
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
