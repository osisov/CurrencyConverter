//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 15.12.2024.
//

import UIKit
import SnapKit

final class CurrencyConverterViewController: UIViewController, CurrencyConverterViewProtocol {
    
    private let interactor: CurrencyConverterInteractorProtocol
    
    private let titleLabel = UILabel()
    private let contentView = CurrencyConverterView()
    private let pickerView = CurrencyPickerView()
    private var pickerViewBottomConstraint: Constraint?

    init(interactor: CurrencyConverterInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupLayout()
        interactor.fetchCurrencyValues()
    }

    private func setupSubviews() {
        titleLabel.text = "Currency Converter"
        titleLabel.textAlignment = .center
        pickerView.addShadow()
        view.addSubview(titleLabel)
        view.addSubview(contentView)
        view.addSubview(pickerView)
        view.backgroundColor = .white
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        view.addGestureRecognizer(tapRecognizer)
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        pickerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            self.pickerViewBottomConstraint = make.bottom
                .equalTo(view.snp.bottom)
                .offset(Constants.pickerOffset200)
                .constraint
            make.height.equalTo(Constants.pickerHeight)
        }
    }
    
    func updateView(with viewModel: CurrencyConverterViewControllerModel) {
        contentView.setup(with: viewModel.currencyConverterModel)
        pickerView.setup(viewModel: viewModel.pickerModel)
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showPickerView() {
        animatePickerViewHeight(Constants.pickerOffsetZero)
    }
    
    func didTapConvert() {
        interactor.convertValue()
    }
    
    func updateCurrencies(_ currencies: [String]) {
        
    }
    
    func setupPickerViewWrapper(_ wrapper: any UIPickerViewWrapper) {
        interactor.setPicker(wrapper)
    }
    
    func didTapApplySelectCurrency() {
        interactor.saveCurrentSelection()
        hiddePickerView()
    }
    
    func didTapCancelSelectCurrency() {
        interactor.restorePreviousSelection()
        hiddePickerView()
    }
    
    private func hiddePickerView() {
        animatePickerViewHeight(Constants.pickerOffset200)
    }
    
    private func animatePickerViewHeight(_ height: Float) {
        pickerViewBottomConstraint?.update(offset: height)
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func tap(_ gesture: UITapGestureRecognizer) {
        hiddePickerView()
    }
}

extension CurrencyConverterViewController {
    enum Constants {
        static let pickerHeight: Float = 240
        static let pickerOffset200: Float = 240
        static let pickerOffsetZero: Float = -40
    }
}
