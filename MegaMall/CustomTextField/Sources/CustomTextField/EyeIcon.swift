//
//  File.swift
//  CustomTextField
//
//  Created by Mohamed Adel on 06/08/2026.
//

import Foundation
import UIKit

private final class PasswordToggleButton: UIButton {
    weak var linkedTextField: UITextField?
}

class EyeIconTextField: UIView {
    
    static func addPasswordToggle(textField: UITextField) {
        
        let icon = PasswordToggleButton(type: .custom)
        icon.linkedTextField = textField
        icon.setImage(UIImage(systemName: "eye"), for: .normal)
        icon.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        icon.tintColor = .gray
        icon.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        icon.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 30 + 15, height: 30))
        icon.center = CGPoint(x: 30 / 2, y: container.bounds.midY)
        container.addSubview(icon)
        
        textField.rightView = container
    }
    
    @objc private static func togglePasswordVisibility(_ sender: UIButton) {
        guard let button = sender as? PasswordToggleButton,
              let textField = button.linkedTextField else { return }
        
        textField.isSecureTextEntry.toggle()
        button.isSelected.toggle()
        
        if let existingText = textField.text, textField.isSecureTextEntry {
            textField.text = ""
            textField.insertText(existingText)
        }
    }
}
