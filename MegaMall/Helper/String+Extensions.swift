//
//  String+Extensions.swift
//  MegaMall
//
//  Created by Mohamed Adel on 09/08/2026.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        let regex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    func isValidPhone() -> Bool {
        let regex = "^(\\+20)?0?1[0125][0-9]{8}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    func isValidName() -> Bool {
        let regex = "^[a-zA-Z\\s]{3,50}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        return self.count >= 8
    }
    
}
