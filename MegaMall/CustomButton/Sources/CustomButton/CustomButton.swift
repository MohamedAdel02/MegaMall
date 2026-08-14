// The Swift Programming Language
// https://docs.swift.org/swift-book
import UIKit
public enum CustomButtonType {
    case primaryDisable
    case borderButton
    
}

extension UIButton {
    
    public func applyStyle(type: CustomButtonType, text: String) {
        
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        switch type {
        case .primaryDisable:
            self.setTitleColor(.white, for: .normal)
            self.setTitleColor(.white, for: .disabled) 
            self.isEnabled = false
            self.backgroundColor = UIColor(named: "Half Grey")

        case .borderButton:
            self.setTitleColor(UIColor(named: "Navy Black"), for: .normal)
            self.backgroundColor = .clear
            self.layer.borderWidth = 1.5
            self.layer.borderColor = UIColor(named: "Navy Black")?.cgColor
        }
        
    }
    
    
    public func setEnabledStatus(_ value: Bool?) {
        let isEnabled = value ?? false
        self.isEnabled = isEnabled
        self.backgroundColor = isEnabled ? UIColor(named: "Blue Ocean") : UIColor(named: "Half Grey")
    }

}
