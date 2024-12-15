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
        view.addSubview(titleLabel)
        view.addSubview(contentView)
        view.backgroundColor = .white
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
    }

    func updateView(with viewModel: CurrencyConverterViewModel) {
        contentView.configure(with: viewModel)
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
