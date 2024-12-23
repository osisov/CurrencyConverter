//
//  Formatter+Extension.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 23.12.2024.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}
