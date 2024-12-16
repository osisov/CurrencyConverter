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
    private let currencyButton = UIButton(type: .system)
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
        textField.rightView = currencyButton
        textField.rightViewMode = .always
        currencyButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        addSubview(textField)
    }

    private func setupLayout() {
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(with viewModel: CurrencyInputViewModel) {
        textField.text = viewModel.amount
        currencyButton.setTitle(viewModel.currency, for: .normal)
        self.onButtonTapped = viewModel.onButtonTapped
    }
    
    @objc private func didButtonTap(_ sender: Any?) {
        onButtonTapped?()
    }
}
