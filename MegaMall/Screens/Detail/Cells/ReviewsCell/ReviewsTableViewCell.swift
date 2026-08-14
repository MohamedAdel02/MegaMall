//
//  ReviewsTableViewCell.swift
//  MegaMall
//
//  Created by Mohamed Adel on 11/08/2026.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var starView: UIView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    static let reuseID = "ReviewsTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        let stars = StarRatingView(rating: 4)
        stars.translatesAutoresizingMaskIntoConstraints = false
        starView.addSubview(stars)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
