//
//  CurrencyConverterProtocols.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 15.12.2024.
//

protocol CurrencyConverterViewProtocol: AnyObject {
    func updateView(with viewModel: CurrencyConverterViewControllerModel)
    func showError(message: String)
    func showPickerView()
    func didTapConvert()
    func updateCurrencies(_ currencies: [String])
    func setupPickerViewWrapper(_ wrapper: UIPickerViewWrapper)
    func didTapApplySelectCurrency()
    func didTapCancelSelectCurrency()
}

protocol CurrencyConverterInteractorProtocol: AnyObject {
    @MainActor func setPicker(_ picker: UIPickerViewWrapper)
    @MainActor func saveCurrentSelection()
    @MainActor func restorePreviousSelection()
    
    func fetchCurrencyValues()
    func convertValue()
    func handleConvertButtonPress() async
    func updateSelectedValue(_ value: String, type: ValueType)
}

protocol CurrencyConverterPresenterProtocol: AnyObject {
    @MainActor func didFetchCurrencyValues(currencies: [String])
    @MainActor func didFetchAmount(_ amount: Amount?)
    @MainActor func didFailToFetchCurrencyValues(with error: Error)    
    func didApplyCurrency(_ currency: CurrencyMeta)
}
