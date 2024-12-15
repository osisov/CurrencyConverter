//
//  CurrencyInputViewModel.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 15.12.2024.
//

struct CurrencyInputViewModel {
    let amount: String
    let currency: String
    let onButtonTapped: (() -> Void)?
}
