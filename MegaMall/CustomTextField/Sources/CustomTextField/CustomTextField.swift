// The Swift Programming Language
// https://docs.swift.org/swift-book
import UIKit

public enum TextFieldType {
    case emailPhone
    case password
    case search

}

extension UITextField {
    
    public func applyStyle(type: TextFieldType, placeHolder: String) {
        
        self.placeholder = placeHolder
        self.backgroundColor = UIColor(named: "Off Grey")
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.borderStyle = .none
        self.font = .systemFont(ofSize: 16)
        self.textColor = .darkGray
        self.setPadding(left: 15, right: 15)
        
        switch type {
        case .emailPhone:
            self.keyboardType = .emailAddress
            self.textContentType = .username
            self.autocapitalizationType = .none
            self.autocorrectionType = .no
            
        case .password:
            self.isSecureTextEntry = true
            self.keyboardType = .default
            self.textContentType = .password
            self.autocapitalizationType = .none
            self.autocorrectionType = .no
            EyeIconTextField.addPasswordToggle(textField: self)

        case .search:
            self.keyboardType = .default
            self.returnKeyType = .search
            self.autocapitalizationType = .none
            self.autocorrectionType = .no
            self.addSearchIcon()
        }
    }
    
    
    public func setPadding(left: CGFloat = 16, right: CGFloat = 16) {
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: left, height: 0))
        leftView = leftPadding
        leftViewMode = .always

        let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: right, height: 0))
        rightView = rightPadding
        rightViewMode = .always
    }


    private func addSearchIcon() {
        let iconView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        iconView.tintColor = .darkGray
        iconView.contentMode = .scaleAspectFit

        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        iconView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        iconView.center = CGPoint(x: containerView.bounds.width / 2, y: containerView.bounds.height / 2)
        containerView.addSubview(iconView)

        rightView = containerView
        rightViewMode = .always
    }
    
    
    public func setErrorState(_ hasError: Bool) {
        layer.borderWidth = hasError ? 1 : 0
        layer.borderColor = hasError ? UIColor.systemRed.cgColor : nil
        backgroundColor = hasError ? UIColor.systemRed.withAlphaComponent(0.1) : UIColor(named: "Off Grey")
    }
    
}
