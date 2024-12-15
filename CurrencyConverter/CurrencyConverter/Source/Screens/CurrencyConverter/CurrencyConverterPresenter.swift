//
//  CurrencyConverterPresenter.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 15.12.2024.
//

final class CurrencyConverterPresenter: CurrencyConverterPresenterProtocol {
    weak var view: CurrencyConverterViewProtocol?

    func didFetchCurrencyValues(amount: String, currency: String) {
        let inputViewModel = CurrencyInputViewModel(amount: amount, currency: currency, onButtonTapped: nil)
        let viewModel = CurrencyConverterViewModel(inputViewModel: inputViewModel, onButtonTapped: nil)
        view?.updateView(with: viewModel)
    }

    func didFailToFetchCurrencyValues(with error: Error) {
        view?.showError(message: "Mock error message")
    }
}
