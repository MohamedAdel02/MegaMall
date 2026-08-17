//
//  LatestNewsTableViewCell.swift
//  MegaMall
//
//  Created by Mohamed Adel on 16/08/2026.
//

import UIKit

class LatestNewsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var newsImageView: UIImageView!
    
    static let reuseID = "LatestNewsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        
        newsImageView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
