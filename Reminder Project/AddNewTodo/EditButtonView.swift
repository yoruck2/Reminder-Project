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

protocol EditButtonViewDelegate {
    func editButtonTapped(button: EditButton)
}

final class EditButtonView: BaseView {
    
    var delegate: EditButtonViewDelegate?
    
    var buttonType: EditButton
    var titleLabel = UILabel()
    var disclosureIndicator = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
    }
    
    init(type: EditButton) {
        self.buttonType = type
        super.init(frame: .zero)
        titleLabel.text = type.rawValue
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    override func configureView() {
        backgroundColor = #colorLiteral(red: 0.1725487709, green: 0.1725491583, blue: 0.1811430752, alpha: 1)
        layer.cornerRadius = 15
        clipsToBounds = true
    }
    
    @objc
    private func handleTap() {
        delegate?.editButtonTapped(button: buttonType)
    }
}

extension EditButtonView {
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
