//
//  RegisterViewController.swift
//  MegaMall
//
//  Created by Mohamed Adel on 08/08/2026.
//

import UIKit
import CustomTextField
import CustomButton

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var issueIcon: UIImageView!
    @IBOutlet weak var issueLabel: UILabel!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()

        textField.delegate = self
        
        textField.applyStyle(type: .emailPhone,placeHolder: "Enter your email or phone number")
        continueButton.applyStyle(type: .primaryDisable, text: "Continue")
        
        issueLabel.text = "Invalid email or phone number"
        issueIcon.isHidden = true
        
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)

        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        continueButton.setEnabledStatus(false)
    }
    

    func bind() {
        
        viewModel.isValidEmailPhone.bind { [weak self] value in
            
            self?.hideIssue(value, textField: self?.textField, icon: self?.issueIcon, label: self?.issueLabel)
            
            guard let text = self?.textField.text, !text.isEmpty else {
                self?.continueButton.setEnabledStatus(false)
                return
            }
            self?.continueButton.setEnabledStatus(value)
        }
    }
    
    func hideIssue(_ value: Bool, textField: UITextField?, icon: UIImageView?, label: UILabel?) {
        
        label?.textColor = value ? UIColor.clear : .redVelvet
        icon?.isHidden = value
        textField?.setErrorState(!value)
    }
    
    @objc private func signInTapped(_ sender: UIButton) {
        let homeVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: homeVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    @objc private func continueTapped(_ sender: UIButton) {
        let verificationVC = VerificationViewController(nibName: "VerificationViewController", bundle: nil)
        verificationVC.emailPhone = textField.text ?? ""
        verificationVC.navigationType = .signUp
        textField.text = ""
        navigationController?.pushViewController(verificationVC, animated: true)
    }
    
}


extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard textField == textField else { return }
        let email = textField.text ?? ""
        viewModel.updateEmail(email)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textField {
            textField.resignFirstResponder()
            
            guard let text = textField.text else { return true }
            
            if viewModel.isValidEmailPhone.value && !text.isEmpty {
                continueTapped(continueButton)
            }
        }
        return true
    }
}

