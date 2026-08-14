//
//  DetailCollectionViewCell.swift
//  MegaMall
//
//  Created by Mohamed Adel on 11/08/2026.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var optionButton: UIButton!
    
    static let reuseID = "DetailCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        optionButton.transform = CGAffineTransform(rotationAngle: .pi / 2)
        
        imageView?.layer.cornerRadius = 15
        imageView?.clipsToBounds = true
        
        let config = UIImage.SymbolConfiguration(pointSize: 13, weight: .regular)
        let image = UIImage(systemName: "ellipsis", withConfiguration: config)
        optionButton.setImage(image, for: .normal)
        
        layer.cornerRadius = 15
        
        
    }

}
