//
//  CurrencyPickerView.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 20.12.2024.
//

import UIKit
import SnapKit

final class CurrencyPickerView: UIView {
    
    // MARK: - Views
    
    private let mainStackView: UIStackView = UIStackView()
    private let buttonsStackView: UIStackView = UIStackView()
    private let pickerView = UIPickerView()
    private let cancelButton: UIButton = UIButton()
    private let applyButton: UIButton = UIButton()
    
    // MARK: - Completetion
    
    private var applyAction: CurrencyPickerViewModel.Action?
    private var cancelAction: CurrencyPickerViewModel.Action?
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubview(mainStackView)
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillProportionally
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainStackView.addArrangedSubview(pickerView)
        mainStackView.addArrangedSubview(buttonsStackView)
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        
        buttonsStackView.addArrangedSubview(cancelButton)
        buttonsStackView.addArrangedSubview(applyButton)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.blue, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction(_:)), for: .touchUpInside)
//        cancelButton.addBorder()
        
        applyButton.setTitle("Apply", for: .normal)
        applyButton.setTitleColor(.blue, for: .normal)
        applyButton.addTarget(self, action: #selector(applyAction(_:)), for: .touchUpInside)
//        applyButton.addBorder()
    }
    
    func setup(viewModel: CurrencyPickerViewModel) {
        applyAction = viewModel.applyAction
        cancelAction = viewModel.cancelAction
        viewModel.setupAction(pickerView)
    }
    
    // MARK: - Actions
    
    @objc private func cancelAction(_ sender: Any?) {
        cancelAction?()
    }
    
    @objc private func applyAction(_ sender: Any?) {
        applyAction?()
    }
}
