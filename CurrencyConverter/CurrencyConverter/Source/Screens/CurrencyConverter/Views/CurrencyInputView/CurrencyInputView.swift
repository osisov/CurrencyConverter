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
    }
    
    @objc private func didButtonTap(_ sender: Any?) {
        onButtonTapped?()
    }
}
