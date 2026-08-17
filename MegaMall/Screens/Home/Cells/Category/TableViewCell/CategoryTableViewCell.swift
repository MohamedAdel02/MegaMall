//
//  CategoryTableViewCell.swift
//  MegaMall
//
//  Created by Mohamed Adel on 16/08/2026.
//

import UIKit
import SkeletonView

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    static let reuseID = "CategoryTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    private func setupViews() {
        selectionStyle = .none

        collectionView.dataSource = self
        collectionView.delegate = self
    
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(
            UINib(nibName: "CategoryCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseID
        )
    }

}


extension CategoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.reuseID,
            for: indexPath
        ) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let columns: CGFloat = 4
        let totalSpacing = padding * (columns + 1)
        let width = (collectionView.bounds.width - totalSpacing) / columns
        return CGSize(width: width, height: width * 1.5)
    }

    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 35, bottom: 20, right: 35)
    }
    
}

extension CategoryTableViewCell: SkeletonCollectionViewDataSource {

    func numSections(in skeletonView: UICollectionView) -> Int {
        return 1
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return CategoryCollectionViewCell.reuseID
    }
}
