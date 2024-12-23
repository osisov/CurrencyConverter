//
//  CurrencyConverterEntities.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 16.12.2024.
//

enum ValueType: Int {
    case source
    case destination
}

struct CurrencyMeta {
    var amountValue: String
    var sourceCurrency: String
    var destinationCurrency: String
}

extension CurrencyMeta {
    static var `default` = CurrencyMeta(amountValue: "100", sourceCurrency: "USD", destinationCurrency: "EUR")
}

extension CurrencyMeta {
    static func make(with amount: ConvertedAmount, source currency: String) -> CurrencyMeta {
        return CurrencyMeta(
            amountValue: amount.amount,
            sourceCurrency: currency,
            destinationCurrency: amount.currency
        )
    }
}
