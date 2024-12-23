//
//  UIView+Extension.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 20.12.2024.
//

import UIKit

extension UIView {
    
    func addShadow(
        color: UIColor = .black,
        opacity: Float = 0.6,
        offset: CGSize = CGSize(width: 3, height: 3),
        radius: CGFloat = 4,
        cornerRadius: CGFloat = 5
    ) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        clipsToBounds = false
    }
}
