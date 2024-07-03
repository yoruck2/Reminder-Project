//
//  EditButtonView.swift
//  Reminder Project
//
//  Created by dopamint on 7/2/24.
//

import UIKit

final class EditButtonView: UILabel {
    
    var
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.1725487709, green: 0.1725491583, blue: 0.1811430752, alpha: 1)
        layer.cornerRadius = 15
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
