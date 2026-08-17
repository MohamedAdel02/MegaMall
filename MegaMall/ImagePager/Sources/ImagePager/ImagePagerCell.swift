//
//  ImagePagerCell.swift
//  ImagePager
//
//  Created by Mohamed Adel on 16/08/2026.
//

import UIKit

public class ImagePagerCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ImagePagerCell"

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        imageView.layer.cornerRadius = 15
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(image: UIImage, contentMode: UIView.ContentMode) {
        imageView.image = image
        imageView.contentMode = contentMode
    }
}

