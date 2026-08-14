//
//  LoginViewController.swift
//  MegaMall
//
//  Created by Mohamed Adel on 06/08/2026.
//

import UIKit
import CustomButton
import CustomTextField

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var emailIssueLabel: UILabel!
    @IBOutlet weak var passwordIssueLabel: UILabel!
    @IBOutlet weak var emailIssueIcon: UIImageView!
    @IBOutlet weak var passwordIssueIcon: UIImageView!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    private var cachedPasswordText: String?
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailIssueLabel.text = "Invalid email or phone number"
        passwordIssueLabel.text = "Password must be at least 8 characters"
        emailIssueIcon.isHidden = true
        passwordIssueIcon.isHidden = true
        
        emailTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .go
        
        emailTextField.applyStyle(type: .emailPhone,placeHolder: "Enter your email or phone number")
        passwordTextField.applyStyle(type: .password,placeHolder: "Enter your password")
        signInButton.applyStyle(type: .primaryDisable, text: "Sign In")
        
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        bind()
    }
    
    private func bind() {
        
        viewModel.enableButton.bind { [weak self] value in
            self?.signInButton.setEnabledStatus(value)
        }
        
        
        viewModel.isValidEmailPhone.bind { [weak self] value in
            
            self?.hideIssue(value, textField: self?.emailTextField, icon: self?.emailIssueIcon, label: self?.emailIssueLabel)
        }
        
        viewModel.isPassword.bind { [weak self] value in
            
            self?.hideIssue(value, textField: self?.passwordTextField, icon: self?.passwordIssueIcon, label: self?.passwordIssueLabel)
        }
    }
    
    
    func hideIssue(_ value: Bool, textField: UITextField?, icon: UIImageView?, label: UILabel?) {
        
        label?.textColor = value ? UIColor.clear : .redVelvet
        icon?.isHidden = value
        textField?.setErrorState(!value)
    }
    
    
    @objc private func forgotPasswordTapped() {
        let resetPasswordVC = ResetPasswordViewController(nibName: "ResetPasswordViewController", bundle: nil)
        navigationController?.pushViewController(resetPasswordVC, animated: true)
    }
    
    @objc private func signUpTapped(_ sender: UIButton) {
        let homeVC = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: homeVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }

}


extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == passwordTextField else { return true }
        
        let currentText = (textField.text as NSString?) ?? ""
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        textField.text = updatedText
        
        viewModel.updatePassword(updatedText)
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard textField == emailTextField else { return }
        let email = emailTextField.text ?? ""
        viewModel.updateEmail(email)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 80, width:self.view.frame.size.width, height:self.view.frame.size.height)
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 80, width:self.view.frame.size.width, height:self.view.frame.size.height)
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
}
