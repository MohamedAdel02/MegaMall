//
//  AccountSetupViewController.swift
//  MegaMall
//
//  Created by Mohamed Adel on 08/08/2026.
//

import UIKit
import CustomButton
import CustomTextField

class AccountSetupViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var referalCodeTextField: UITextField!
    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var confirmationButton: UIButton!
    
    let viewModel = AccountSetupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        
        nameTextField.delegate = self
        passwordTextField.delegate = self
        referalCodeTextField.delegate = self
        
        nameTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .next
        referalCodeTextField.returnKeyType = .go
        
        nameTextField.applyStyle(type: .emailPhone,placeHolder: "Enter your email or phone number")
        referalCodeTextField.applyStyle(type: .emailPhone,placeHolder: "Enter your email or phone number")
        passwordTextField.applyStyle(type: .password,placeHolder: "Enter your password")
        
        confirmationButton.applyStyle(type: .primaryDisable, text: "Confirmation")
        
        issueLabel.text = "Password must be at least 8 characters"
        
        bind()
    }
    
    
    private func bind() {
        viewModel.enableButton.bind { [weak self] value in
            self?.confirmationButton.setEnabledStatus(value)
        }
    }

}


extension AccountSetupViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == passwordTextField else { return true }
        
        let currentText = (textField.text as NSString?) ?? ""
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        textField.text = updatedText
        
        viewModel.updatePassword(updatedText)
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard textField == nameTextField else { return }
        let email = nameTextField.text ?? ""
        viewModel.updateName(email)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            referalCodeTextField.becomeFirstResponder()
        } else if textField == referalCodeTextField {
            referalCodeTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 100, width:self.view.frame.size.width, height:self.view.frame.size.height)
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 100, width:self.view.frame.size.width, height:self.view.frame.size.height)
        })
    }
    
}


