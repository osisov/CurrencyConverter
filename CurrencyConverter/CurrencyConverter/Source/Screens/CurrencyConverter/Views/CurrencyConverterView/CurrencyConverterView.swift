//
//  CurrencyConverterView.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 15.12.2024.
//

import UIKit
import SnapKit

final class CurrencyConverterView: UIView {
    
    enum Constants {
        static let inset16: Float = 16
        static let size44: Float = 44
    }
    
    private let currencyInputView = CurrencyInputView()
    private let convertButton = UIButton(type: .system)
    private let stack = UIStackView()
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
        convertButton.setTitle("Convert", for: .normal)
        convertButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        addSubview(stack)
        
        stack.addArrangedSubview(currencyInputView)
        stack.addArrangedSubview(convertButton)
        stack.axis = .vertical
    }

    private func setupLayout() {

        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.inset16)
        }
        
        currencyInputView.snp.makeConstraints { make in
            make.height.equalTo(Constants.size44)
        }

        convertButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.size44)
        }
    }

    func setup(with viewModel: CurrencyConverterViewModel) {
        currencyInputView.setup(with: viewModel.inputViewModel)
        self.onButtonTapped = viewModel.onButtonTapped
    }
    
    @objc private func didTapButton(_ sender: Any?) {
        onButtonTapped?()
    }
}

