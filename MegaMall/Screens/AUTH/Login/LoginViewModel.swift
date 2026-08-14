//
//  LoginViewModel.swift
//  MegaMall
//
//  Created by Mohamed Adel on 06/08/2026.
//

import Foundation

class LoginViewModel {
    
    var enableButton: Observable<Bool> = Observable(false)
    var isValidEmailPhone: Observable<Bool> = Observable(true)
    var isPassword: Observable<Bool> = Observable(true)
    
    private var currentEmail: String = ""
    private var currentPassword: String = ""
    
    func updateEmail(_ email: String) {
        currentEmail = email
        isValidEmailPhone.value = isValidEmailOrPhone(email) || email.isEmpty
        updateButtonState()
    }
    
    func updatePassword(_ password: String) {
        currentPassword = password
        isPassword.value = password.isValidPassword() || password.isEmpty
        updateButtonState()
    }
    
    private func updateButtonState() {
        enableButton.value = isValidEmailOrPhone(currentEmail) && currentPassword.isValidPassword()
    }
    
    private func isValidEmailOrPhone(_ text: String) -> Bool {
        return text.isValidEmail() || text.isValidPhone()
    }
}
