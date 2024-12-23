//
//  CurrencyPickerViewModel.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 20.12.2024.
//

struct CurrencyPickerViewModel {
    typealias Action = () -> Void
    
    let setupAction: (_ pickerViewWrapper: UIPickerViewWrapper) -> Void
    let applyAction: Action
    let cancelAction: Action
}
