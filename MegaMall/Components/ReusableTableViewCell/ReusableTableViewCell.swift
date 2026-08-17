//
//  ReusableTableViewCell.swift
//  MegaMall
//
//  Created by Mohamed Adel on 11/08/2026.
//

import UIKit
import SkeletonView

class ReusableTableViewCell: UITableViewCell {

    static let reuseID = "FeaturedProductTableViewCell"

    @IBOutlet weak var bannerLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    private func setupViews() {
        selectionStyle = .none

        bannerView.isHidden = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
                
        bannerView.layer.cornerRadius = 20

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: 160, height: 260)
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .offGrey
        
        collectionView.register(
            UINib(nibName: "DetailCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: DetailCollectionViewCell.reuseID
        )
    }
    
    func configure(color: UIColor, title: String, image: UIImage) {
        bannerView.backgroundColor = color
        bannerLabel.text = title
        bannerImageView.image = image
    }

}

extension ReusableTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DetailCollectionViewCell.reuseID,
            for: indexPath
        ) as? DetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 15
        let columns: CGFloat = 2
        let totalSpacing = padding * (columns + 1)
        let width = (collectionView.bounds.width - totalSpacing) / columns
        return CGSize(width: width, height: width * 1.4)
    }

    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
}


extension ReusableTableViewCell: SkeletonCollectionViewDataSource {

    func numSections(in skeletonView: UICollectionView) -> Int {
        return 1
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return DetailCollectionViewCell.reuseID
    }
}
