//
//  CurrencyConverterBuilder.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 15.12.2024.
//

import UIKit

final class CurrencyConverterBuilder {
    static func build() -> UIViewController {
        let presenter = CurrencyConverterPresenter()
        let interactor = CurrencyConverterInteractor(presenter: presenter)
        let viewController = CurrencyConverterViewController(interactor: interactor)
        presenter.view = viewController
        return viewController
    }
}
