//
//  UIView+Extension.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 20.12.2024.
//

import UIKit

extension UIView {
    func addBorder(color: UIColor = .blue, width: CGFloat = 1, cornerRadius: CGFloat = 10) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    func addShadow(
        color: UIColor = .black,
        opacity: Float = 0.2,
        offset: CGSize = CGSize(width: 0, height: 2),
        radius: CGFloat = 4,
        cornerRadius: CGFloat = 0
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
    }
}
