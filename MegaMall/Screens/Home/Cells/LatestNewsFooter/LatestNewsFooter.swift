//
//  LatestNewsFooter.swift
//  MegaMall
//
//  Created by Mohamed Adel on 16/08/2026.
//

import UIKit

class LatestNewsFooter: UIViewFromNib {

    
    @IBOutlet weak var button: UIButton!
    
    
    override func layoutSubviews() {
        
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.05, green: 0.1, blue: 0.2, alpha: 1).cgColor
        button.setTitleColor(UIColor(red: 0.05, green: 0.1, blue: 0.2, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .clear
        
    }
    
}
