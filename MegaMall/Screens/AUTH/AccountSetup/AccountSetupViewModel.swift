//
//  AccountSetupViewModel.swift
//  MegaMall
//
//  Created by Mohamed Adel on 08/08/2026.
//

import Foundation

class AccountSetupViewModel {
    
    var enableButton: Observable<Bool> = Observable(false)
    var isValidName: Observable<Bool> = Observable(true)
    var isPassword: Observable<Bool> = Observable(true)
    
    private var currentName: String = ""
    private var currentPassword: String = ""
    
    func updateName(_ name: String) {
        currentName = name
        isValidName.value = name.isValidName() || name.isEmpty
        updateButtonState()
    }
    
    func updatePassword(_ password: String) {
        currentPassword = password
        isPassword.value = password.isValidPassword() || password.isEmpty
        updateButtonState()
    }
    
    private func updateButtonState() {
        enableButton.value = currentName.isValidName() && currentPassword.isValidPassword()
    }

}
