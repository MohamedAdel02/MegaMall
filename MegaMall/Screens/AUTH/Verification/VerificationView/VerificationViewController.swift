//
//  VerificationViewController.swift
//  MegaMall
//
//  Created by Mohamed Adel on 08/08/2026.
//

import UIKit
import CustomButton
import CustomTextField

enum VerificationNavigation {
    case resetPassword
    case signUp
}


class VerificationViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var OTPStackView: UIStackView!
    @IBOutlet weak var emailPhoneLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var resendButton: UIButton!
    
    var emailPhone = ""
    
    private let otpController = OTPController()
    var navigationType: VerificationNavigation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()

        continueButton.applyStyle(type: .primaryDisable, text: "Continue")
        
        emailPhoneLabel.text = emailPhone
        
        changeButton.addTarget(self, action: #selector(changeTapped), for: .touchUpInside)
        resendButton.addTarget(self, action: #selector(resendTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
        otpController.configure(stackView: OTPStackView, digitCount: 4) { [weak self] code in
            self?.continueButton.setEnabledStatus(code.count == 4)
        }
        
    }
    
    @objc func changeTapped() {
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func continueTapped() {
        
        switch navigationType {
        case .resetPassword:
            let updatePasswordVC = UpdatePasswordViewController(nibName: "UpdatePasswordViewController", bundle: nil)
            navigationController?.pushViewController(updatePasswordVC, animated: true)
        case .signUp:
            let accountSetupVC = AccountSetupViewController(nibName: "AccountSetupViewController", bundle: nil)
            navigationController?.pushViewController(accountSetupVC, animated: true)
        case .none:
            return
        }
    }
    

    @objc func resendTapped() {
        let alert = UIAlertController(
            title: "Code Sent",
            message: "A new verification code has been sent to your email / phone.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}
