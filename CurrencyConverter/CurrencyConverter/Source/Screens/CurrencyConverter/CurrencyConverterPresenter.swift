//
//  CurrencyConverterPresenter.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 15.12.2024.
//

final class CurrencyConverterPresenter: CurrencyConverterPresenterProtocol {

    weak var view: CurrencyConverterViewProtocol?

    func didFetchCurrencyValues(currencies: [String]) {        
        updateView(currency: .default)
    }
    
    func didSucessFetchAmount(with message: String) {
        view?.showAlert(message: message)
    }

    func didFailToFetchCurrencyValues(with error: String) {
        view?.showAlert(message: error)
    }
    
    func didApplyCurrency(_ currency: CurrencyMeta) {
        updateView(currency: currency)
    }
}

private extension CurrencyConverterPresenter {
    
    func updateView(currency: CurrencyMeta) {
        let currencyConverterModel = makeCurrencyConverterViewModel(currency: currency)
        let pickerViewModel = makePickerViewModel()
        let viewModel = CurrencyConverterViewControllerModel(
            currencyConverterModel: currencyConverterModel,
            pickerModel: pickerViewModel
        )
        
        view?.updateView(with: viewModel)
    }
    
    func makeCurrencyConverterViewModel(currency: CurrencyMeta) -> CurrencyConverterViewModel {
        let inputViewModel = CurrencyInputViewModel(
            amount: currency.amountValue,
            currency: "\(currency.sourceCurrency)/\(currency.destinationCurrency)"
        ) { [weak self] string in
            guard let number = Double(string ?? "") else { return }
            self?.view?.didIpuntAmount(number)
        } onButtonTapped: { [weak self] in
            self?.view?.showPickerView()
        }
        
        return CurrencyConverterViewModel(
            inputViewModel: inputViewModel
        ) { [weak self] in
            self?.view?.didTapConvert()
        }
    }
    
    func makePickerViewModel() -> CurrencyPickerViewModel {
        return CurrencyPickerViewModel { [weak self] pickerViewWrapper in
            self?.view?.setupPickerViewWrapper(pickerViewWrapper)
        } applyAction: { [weak self] in
            self?.view?.didTapApplySelectCurrency()
        } cancelAction: { [weak self] in
            self?.view?.didTapCancelSelectCurrency()
        }
    }
}
