//
//  ResetPasswordViewController.swift
//  MegaMall
//
//  Created by Mohamed Adel on 08/08/2026.
//

import UIKit
import CustomTextField
import CustomButton

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var issueIcon: UIImageView!
    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    let viewModel = ResetPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()

        textField.delegate = self
        
        textField.applyStyle(type: .emailPhone,placeHolder: "Enter your email or phone number")
        button.applyStyle(type: .primaryDisable, text: "Reset")
        
        textField.returnKeyType = .go
        
        issueLabel.text = "Invalid email or phone number"
        issueIcon.isHidden = true
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        button.setEnabledStatus(false)
    }
    
    
    func bind() {
        
        viewModel.isValidEmailPhone.bind { [weak self] value in
            
            self?.hideIssue(value, textField: self?.textField, icon: self?.issueIcon, label: self?.issueLabel)
            
            guard let text = self?.textField.text, !text.isEmpty else {
                self?.button.setEnabledStatus(false)
                return
            }
            
            self?.button.setEnabledStatus(value)
        }
    }
    

    func hideIssue(_ value: Bool, textField: UITextField?, icon: UIImageView?, label: UILabel?) {
        
        label?.textColor = value ? UIColor.clear : .redVelvet
        icon?.isHidden = value
        textField?.setErrorState(!value)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let verificationVC = VerificationViewController(nibName: "VerificationViewController", bundle: nil)
        verificationVC.emailPhone = textField.text ?? ""
        verificationVC.navigationType = .resetPassword
        textField.text = ""
        navigationController?.pushViewController(verificationVC, animated: true)
    }
    
}


extension ResetPasswordViewController: UITextFieldDelegate {
    
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
                buttonTapped(button)
            }
        }
        return true
    }
}
