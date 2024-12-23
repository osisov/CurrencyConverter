//
//  Amount.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 16.12.2024.
//

struct ConvertedAmount: Decodable {
    let amount: String
    let currency: String
}

extension ConvertedAmount {
    static var `default`: ConvertedAmount {
        ConvertedAmount(amount: "100", currency: "USD/EUR")
    }
}
