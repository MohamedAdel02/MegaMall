//
//  UpdatePasswordViewController.swift
//  MegaMall
//
//  Created by Mohamed Adel on 08/08/2026.
//

import UIKit
import CustomButton
import CustomTextField

class UpdatePasswordViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var saveUpdateButton: UIButton!
    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var iconIssue: UIImageView!
    
    let viewModel = UpdatePasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        passwordTextField.returnKeyType = .next
        confirmPasswordTextField.returnKeyType = .go

        passwordTextField.applyStyle(type: .password,placeHolder: "Password must be at least 8 characters")
        confirmPasswordTextField.applyStyle(type: .password,placeHolder: "Enter your new password again")
        
        saveUpdateButton.applyStyle(type: .primaryDisable, text: "Save Update")
        
        bind()
    }
    
    private func bind() {
        viewModel.enableButton.bind { [weak self] value in
            self?.saveUpdateButton.setEnabledStatus(value)
        }
        
        viewModel.passwordIssueMessage.bind { [weak self] message in
            self?.hideIssue(message)
        }
    }
    

    func hideIssue(_ message: String?) {
        if let message {
            issueLabel.text = message
            issueLabel.textColor = .redVelvet
            iconIssue.isHidden = false
            confirmPasswordTextField.setErrorState(true)
            passwordTextField.setErrorState(true)
        } else {
            issueLabel.textColor = .clear
            iconIssue.isHidden = true
            confirmPasswordTextField.setErrorState(false)
            passwordTextField.setErrorState(false)
        }
    }
    
}


extension UpdatePasswordViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == passwordTextField || textField == confirmPasswordTextField else { return true }
        
        let currentText = (textField.text as NSString?) ?? ""
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        textField.text = updatedText
        
        if textField == passwordTextField {
            viewModel.updatePassword(updatedText)
        } else {
            viewModel.updateConfirmPassword(updatedText)
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        } else if textField == confirmPasswordTextField {
            confirmPasswordTextField.resignFirstResponder()
        }
        return true
    }

}
