//
//  CategoryCollectionViewCell.swift
//  MegaMall
//
//  Created by Mohamed Adel on 16/08/2026.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let reuseID = "CategoryCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 15
        
    }

}
