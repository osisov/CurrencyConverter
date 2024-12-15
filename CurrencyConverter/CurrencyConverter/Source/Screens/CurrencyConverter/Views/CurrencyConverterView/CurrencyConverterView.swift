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
        addSubview(currencyInputView)
        addSubview(convertButton)
    }

    private func setupLayout() {

        currencyInputView.snp.makeConstraints { make in
            
            make.top.equalToSuperview().offset(Constants.size44)
            make.horizontalEdges.equalToSuperview().inset(Constants.inset16)
            make.height.equalTo(Constants.size44)
        }

        convertButton.snp.makeConstraints { make in
            make.top.equalTo(currencyInputView.snp.bottom).offset(Constants.inset16)
            make.leading.trailing.equalToSuperview().inset(Constants.inset16)
            make.height.equalTo(Constants.size44)
        }
    }

    func configure(with viewModel: CurrencyConverterViewModel) {
        currencyInputView.configure(with: viewModel.inputViewModel)
        self.onButtonTapped = viewModel.onButtonTapped
    }
}

