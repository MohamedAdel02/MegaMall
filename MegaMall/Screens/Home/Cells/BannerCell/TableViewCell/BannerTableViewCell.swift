//
//  BannerTableViewCell.swift
//  MegaMall
//
//  Created by Mohamed Adel on 17/08/2026.
//

import UIKit
import SkeletonView

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var timer: Timer?
    private var currentIndex = 0
    
    static let reuseID = "BannerTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.collectionViewLayout = makeBannerLayout()
        
        collectionView.register(
            UINib(nibName: "BannerCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: BannerCollectionViewCell.reuseID
        )
        
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.moveToNextImage()
        }
    }

    func moveToNextImage() {
        
        currentIndex += 1
        if currentIndex >= collectionView.numberOfItems(inSection: 0) {
            currentIndex = 0
        }

        collectionView.scrollToItem(
            at: IndexPath(item: currentIndex, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }
    
    func stopSkeletonAnimations() {
        collectionView.visibleCells.forEach { cell in
            cell.stopSkeletonAnimation()
            cell.hideSkeleton(transition: .none)
        }
        collectionView.hideSkeleton(reloadDataAfter: true, transition: .none)
    }
    
    private func makeBannerLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(200)),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 12
        section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)

        return UICollectionViewCompositionalLayout(section: section)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    deinit {
        timer?.invalidate()
    }
    
}


extension BannerTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BannerCollectionViewCell.reuseID,
            for: indexPath
        ) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension BannerTableViewCell: SkeletonCollectionViewDataSource {

    func numSections(in skeletonView: UICollectionView) -> Int {
        return 1
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return BannerCollectionViewCell.reuseID
    }
}



