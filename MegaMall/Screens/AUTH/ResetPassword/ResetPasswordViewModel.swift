//
//  ResetPasswordViewModel.swift
//  MegaMall
//
//  Created by Mohamed Adel on 08/08/2026.
//

import Foundation

class ResetPasswordViewModel {
    
    var isValidEmailPhone: Observable<Bool> = Observable(true)
        
    func updateEmail(_ email: String) {
        isValidEmailPhone.value = isValidEmailOrPhone(email) || email.isEmpty
    }
    
    private func isValidEmailOrPhone(_ text: String) -> Bool {
        return text.isValidEmail() || text.isValidPhone()
    }
    
}
