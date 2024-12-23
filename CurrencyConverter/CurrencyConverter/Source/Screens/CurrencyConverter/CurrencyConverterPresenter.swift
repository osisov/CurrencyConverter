//
//  CurrencyConverterPresenter.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 15.12.2024.
//

final class CurrencyConverterPresenter: CurrencyConverterPresenterProtocol {

    weak var view: CurrencyConverterViewProtocol?

    func didFetchCurrencyValues(currencies: [String]) {
        view?.updateCurrencies(currencies)
        view?.showPickerView()
        updateView(currency: .default)
    }
    
    func didFetchAmount(_ amount: Amount?) {
        guard let amount else {
            return
        }
        
        updateView(amount: amount)
    }

    func didFailToFetchCurrencyValues(with error: Error) {
        view?.showError(message: "Mock error message")
    }
    
    func didApplyCurrency(_ currency: CurrencyMeta) {
        updateView(currency: currency)
    }
}

private extension CurrencyConverterPresenter {
    func updateView(amount: Amount) {
        let inputViewModel = CurrencyInputViewModel(amount: "0", currency: "USD/EUR") { [weak self] in
            self?.view?.showPickerView()
        }
        
        let viewModel = CurrencyConverterViewModel(
            inputViewModel: inputViewModel
        ) { [weak self] in
            self?.view?.didTapConvert()
        }
        
//        let pickerViewModel = CurrencyPickerViewModel(setupAction: <#T##(any UIPickerViewWrapper) -> Void##(any UIPickerViewWrapper) -> Void##(_ pickerViewWrapper: any UIPickerViewWrapper) -> Void#>)
        
//        view?.updateView(with: viewModel)
    }
    
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
        ) { [weak self] in
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
