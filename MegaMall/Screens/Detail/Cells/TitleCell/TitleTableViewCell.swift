//
//  TitleTableViewCell.swift
//  MegaMall
//
//  Created by Mohamed Adel on 11/08/2026.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var numOfReviewsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    static let reuseID = "TitleTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        productImageView?.image = UIImage(named: "HeadPhones")
        productImageView?.contentMode = .scaleAspectFill
        
        productImageView?.layer.cornerRadius = 50
        productImageView?.clipsToBounds = true
        
        availabilityLabel.layer.cornerRadius = 13
        availabilityLabel.layer.masksToBounds = true
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        selectionStyle = .none

    }
    
}
