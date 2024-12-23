//
//  Untitled.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 15.12.2024.
//

import Foundation

final class CurrencyConverterInteractor: CurrencyConverterInteractorProtocol {
    
    private let presenter: CurrencyConverterPresenterProtocol
    private let apiService: CurrencyConverterAPIProtocol
    private let pickerDataSource: CurrencyPickerDataSourceProtocol
    
    private var meta: CurrencyMeta = .default

    init(
        presenter: CurrencyConverterPresenterProtocol,
        apiService: CurrencyConverterAPIProtocol = CurrencyConverterAPI(),
        pickerDataSource: CurrencyPickerDataSourceProtocol = CurrencyPickerDataSource()
    ) {
        self.presenter = presenter
        self.apiService = apiService
        self.pickerDataSource = pickerDataSource
    }
    
    func setPicker(_ picker: UIPickerViewWrapper) {
        pickerDataSource.setPicker(picker)
    }
    
    func saveCurrentSelection() {
        pickerDataSource.saveCurrentSelection()
        updateSelectedValue()
    }
    
    func restorePreviousSelection() {
        pickerDataSource.restorePreviousSelection()
    }

    func fetchCurrencyValues() {
        Task { [weak self] in
            do {
                let values = try await self?.apiService.fetchAvailableCurrencies()
                await self?.presenter.didFetchCurrencyValues(currencies: values ?? [])
                if let values, values.isEmpty == false {
                    await self?.pickerDataSource.applyDataSource(values)
                }
            } catch {
                await self?.presenter.didFailToFetchCurrencyValues(with: error)
            }
        }
    }

    func handleConvertButtonPress() async {
        await presenter.didFailToFetchCurrencyValues(with: NSError(domain: "Mock", code: 0, userInfo: nil))
    }
    
    func convertValue() {
        Task { [weak self] in
            do {
                guard let request = self?.makeConversionRequest(), let meta = self?.meta else {
                    return
                }
                
                let amount = try await self?.apiService.fetchConvertedAmount(for: request)
                await self?.didFetchAmount(amount)
            } catch {
                await self?.presenter.didFailToFetchCurrencyValues(with: error)
            }
        }
    }
    
    func updateSelectedValue(_ value: String, type: ValueType) {
        switch type {
        case .source:
            meta.sourceCurrency = value
        case .destination:
            meta.destinationCurrency = value
        }
        
        presenter.didApplyCurrency(meta)
    }
    
    func updateInputedValue(_ value: Double) {
        meta.amountValue = "\(value)"
    }
    
    private func updateSelectedValue() {
        if let sourceCurrency = pickerDataSource.selectedComponent1,
            let destinationCurrency = pickerDataSource.selectedComponent2 {
            meta.sourceCurrency = sourceCurrency
            meta.destinationCurrency = destinationCurrency
            
            presenter.didApplyCurrency(meta)
        }
    }
    
    private func makeConversionRequest() -> ConversionRequest {
        ConversionRequest(
            amount: meta.amountValue,
            sourceCurrency: meta.sourceCurrency,
            targetCurrency: meta.destinationCurrency
        )
    }
    
    private func didFetchAmount(_ amount: ConvertedAmount?) async {
        guard let amount else { return }
        let message = "\(amount.currency) \(amount.amount)"
        await presenter.didSucessFetchAmount(with: message)
    }
}
