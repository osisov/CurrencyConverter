//
//  Array+Extension.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 16.12.2024.
//

extension Array {
    func objectAt(index: Int) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        return self[index]
    }
}
