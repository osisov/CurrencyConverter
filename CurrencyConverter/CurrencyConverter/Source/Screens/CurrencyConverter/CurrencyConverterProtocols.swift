//
//  CurrencyConverterProtocols.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 15.12.2024.
//

protocol CurrencyConverterViewProtocol: AnyObject {
    func updateView(with viewModel: CurrencyConverterViewModel)
    func showError(message: String)
}

protocol CurrencyConverterInteractorProtocol: AnyObject {
    func fetchCurrencyValues()
    func handleConvertButtonPress()
}

protocol CurrencyConverterPresenterProtocol: AnyObject {
    func didFetchCurrencyValues(amount: String, currency: String)
    func didFailToFetchCurrencyValues(with error: Error)
}
