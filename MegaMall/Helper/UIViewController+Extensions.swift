//
//  UIViewController+Extensions.swift
//  MegaMall
//
//  Created by Mohamed Adel on 10/08/2026.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
