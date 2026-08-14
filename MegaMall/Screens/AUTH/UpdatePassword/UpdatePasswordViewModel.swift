//
//  UpdatePasswordViewModel.swift
//  MegaMall
//
//  Created by Mohamed Adel on 08/08/2026.
//

import Foundation

class UpdatePasswordViewModel {
    
    var enableButton: Observable<Bool> = Observable(false)
    var passwordIssueMessage: Observable<String?> = Observable(nil)
    
    private var password: String = ""
    private var confirmPassword: String = ""
    
    func updatePassword(_ text: String) {
        password = text
        updateIssueMessage()
        updateButtonState()
    }
    
    func updateConfirmPassword(_ text: String) {
        confirmPassword = text
        updateIssueMessage()
        updateButtonState()
    }
    
    private func updateIssueMessage() {
        if password.count < 8 {
            passwordIssueMessage.value = "Password must be at least 8 characters"
        } else if password != confirmPassword {
            passwordIssueMessage.value = "Passwords do not match"
        } else {
            passwordIssueMessage.value = nil
        }
    }
    
    private func updateButtonState() {
        enableButton.value = password.count >= 8 && password == confirmPassword
    }
}
