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
    private let pickerView = UIPickerView()
    
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
        setupPickerView()
        interactor.fetchCurrencyValues()
    }

    private func setupSubviews() {
        pickerView.isHidden = false
        titleLabel.text = "Currency Converter"
        titleLabel.textAlignment = .center
        contentView.setContentCompressionResistancePriority(.required, for: .vertical)
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
            make.leading.trailing.equalToSuperview()
            self.pickerViewBottomConstraint = make.bottom
                .equalTo(view.snp.bottom)
                .offset(Constants.pickerOffset200)
                .constraint
            make.height.equalTo(Constants.pickerHeight)
        }
    }
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    func updateView(with viewModel: CurrencyConverterViewModel) {
        contentView.configure(with: viewModel)
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showPickerView() {
        animatePickerViewHeight(Constants.pickerOffsetZero)
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

extension CurrencyConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Option \(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        hiddePickerView()
    }
}

extension CurrencyConverterViewController {
    enum Constants {
        static let pickerHeight: Float = 200
        static let pickerOffset200: Float = 200
        static let pickerOffsetZero: Float = .zero
    }
}
