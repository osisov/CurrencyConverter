//
//  CurrencyPickerDataSource.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 19.12.2024.
//

import UIKit

@MainActor
protocol UIPickerViewWrapper: AnyObject {
    var dataSource: (any UIPickerViewDataSource)? { set get }
    var delegate: (any UIPickerViewDelegate)? { set get }
    
    func reloadAllComponents()
    func selectRow(_ row: Int, inComponent component: Int, animated: Bool)
}

@MainActor
protocol CurrencyPickerDataSourceProtocol: AnyObject {
    var selectedComponent1: String? { get }
    var selectedComponent2: String? { get }
    
    func setPicker(_ picker: UIPickerViewWrapper?)
    func applyDataSource(_ dataSource: [String])
    func saveCurrentSelection()
    func restorePreviousSelection()
}

final class CurrencyPickerDataSource: NSObject {
    private(set) var selectedComponent1: String?
    private(set) var selectedComponent2: String?
    
    private var previousSelectedComponent1: String?
    private var previousSelectedComponent2: String?
    
    private var dataSource: [String] = [String]()
    private weak var picker: UIPickerViewWrapper?
}

extension CurrencyPickerDataSource: CurrencyPickerDataSourceProtocol {
    
    func setPicker(_ picker: UIPickerViewWrapper?) {
        self.picker = picker
        picker?.dataSource = self
        picker?.delegate = self
    }
    
    func applyDataSource(_ dataSource: [String]) {
        self.dataSource = dataSource
        picker?.reloadAllComponents()
    }
    
    func saveCurrentSelection() {
        previousSelectedComponent1 = selectedComponent1
        previousSelectedComponent2 = selectedComponent2
    }

    func restorePreviousSelection() {
        selectedComponent1 = previousSelectedComponent1
        selectedComponent2 = previousSelectedComponent2
    }

    func getSelectedValues() -> (String, String) {
        return (selectedComponent1 ?? "", selectedComponent2 ?? "")
    }
}

extension CurrencyPickerDataSource: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource.objectAt(index: row)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedComponent1 = dataSource.objectAt(index: row)
        } else {
            selectedComponent2 = dataSource.objectAt(index: row)
        }
    }
}

extension UIPickerView: UIPickerViewWrapper {}