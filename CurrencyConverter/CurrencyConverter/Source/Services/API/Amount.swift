//
//  Amount.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 16.12.2024.
//

struct Amount: Decodable {
    let amount: String
    let currency: String
}

extension Amount {
    static var `default`: Amount {
        Amount(amount: "100", currency: "USD/EUR")
    }
}
