//
//  CurrencyConverterAPI.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 16.12.2024.
//

protocol CurrencyConverterAPIProtocol: AnyObject {
    func fetchConvertedAmount() async throws -> Amount
    func fetchAvailableCurrencies() async throws -> [String]
}

final class CurrencyConverterAPI: CurrencyConverterAPIProtocol {
    
    func fetchConvertedAmount() async throws -> Amount {
            return Amount(amount: "1000", currency: "EUR")
    }
    
    func fetchAvailableCurrencies() async throws -> [String] {
        return ["USD", "EUR"]
    }
}
