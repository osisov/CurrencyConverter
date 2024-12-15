//
//  Untitled.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 15.12.2024.
//

import Foundation

final class CurrencyConverterInteractor: CurrencyConverterInteractorProtocol {
    private let presenter: CurrencyConverterPresenterProtocol

    init(presenter: CurrencyConverterPresenterProtocol) {
        self.presenter = presenter
    }

    func fetchCurrencyValues() {
        presenter.didFetchCurrencyValues(amount: "", currency: "USD")
    }

    func handleConvertButtonPress() {
        presenter.didFailToFetchCurrencyValues(with: NSError(domain: "Mock", code: 0, userInfo: nil))
    }
}
