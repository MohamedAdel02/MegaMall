//
//  BannerCollectionViewCell.swift
//  MegaMall
//
//  Created by Mohamed Adel on 17/08/2026.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    static let reuseID = "BannerCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bannerImageView.clipsToBounds = true
        bannerImageView.layer.cornerRadius = 20
    }

}

