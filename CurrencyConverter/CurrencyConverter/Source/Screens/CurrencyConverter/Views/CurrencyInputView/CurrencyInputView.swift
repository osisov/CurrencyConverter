//
//  CurrencyInputView.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 15.12.2024.
//

import UIKit
import SnapKit

final class CurrencyInputView: UIView {
    private let textField = UITextField()
    private let button = UIButton(type: .system)
    private var inputAction: ((_ string: String?) -> Void)?
    private var onButtonTapped: (() -> Void)?

    init() {
        super.init(frame: .zero)
        setupSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        textField.placeholder = "Enter amount"
        textField.borderStyle = .roundedRect
        textField.rightView = button
        textField.rightViewMode = .always
        textField.delegate = self
        textField.keyboardType = .numberPad
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.addTarget(self, action: #selector(didButtonTap(_:)), for: .touchUpInside)
        addSubview(textField)
    }

    private func setupLayout() {
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setup(with viewModel: CurrencyInputViewModel) {
        textField.text = viewModel.amount
        button.setTitle(viewModel.currency, for: .normal)
        self.onButtonTapped = viewModel.onButtonTapped
        self.inputAction = viewModel.inputAction
    }
    
    @objc private func didButtonTap(_ sender: Any?) {
        onButtonTapped?()
    }
}

extension CurrencyInputView: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else {
            return true
        }
        
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        inputAction?(updatedText)
        return true
    }
}
