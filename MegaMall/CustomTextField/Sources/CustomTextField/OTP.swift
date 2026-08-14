//
//  File.swift
//  CustomTextField
//
//  Created by Mohamed Adel on 08/08/2026.
//

import UIKit

public class OTPController: NSObject, UITextFieldDelegate {
    
    var textFields: [UITextField] = []
    var onChange: ((String) -> Void)?

    var code: String {
        textFields.map { $0.text ?? "" }.joined()
    }
    
    public func configure(
        stackView: UIStackView,
        digitCount: Int,
        boxSize: CGSize = CGSize(width: 64, height: 64),
        backgroundColor: UIColor = .systemGray6,
        cornerRadius: CGFloat = 12,
        font: UIFont = .systemFont(ofSize: 20, weight: .medium),
        onChange: @escaping (String) -> Void
    ) {
        
        self.onChange = onChange

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        textFields = (0..<digitCount).map { index in
            let field = UITextField()
            field.tag = index
            field.delegate = self
            field.backgroundColor = backgroundColor
            field.textAlignment = .center
            field.keyboardType = .numberPad
            field.font = font
            field.layer.cornerRadius = cornerRadius
            field.layer.masksToBounds = true
            field.widthAnchor.constraint(equalToConstant: boxSize.width).isActive = true
            field.heightAnchor.constraint(equalToConstant: boxSize.height).isActive = true
            stackView.addArrangedSubview(field)
            return field
        }
        
//        textFields.first?.becomeFirstResponder()
    }
    
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let index = textField.tag
        
        if string.count > 1 {
            handlePaste(string)
            return false
        }
        if string.isEmpty {
               textField.text = ""
               if index > 0 { textFields[index - 1].becomeFirstResponder() }
               onChange?(code)
               return false
           }
        guard string.rangeOfCharacter(from: .decimalDigits) != nil else { return false }
        
        textField.text = string
        if index < textFields.count - 1 {
            textFields[index + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        onChange?(code)
        return false
    }
    
    public func handlePaste(_ string: String) {
        let digits = string.filter { $0.isNumber }
        for (index, char) in digits.prefix(textFields.count).enumerated() {
            textFields[index].text = String(char)
        }
        onChange?(code)
    }
    
}
