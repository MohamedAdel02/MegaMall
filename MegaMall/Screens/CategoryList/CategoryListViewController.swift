//
//  CategoryListViewController.swift
//  MegaMall
//
//  Created by Mohamed Adel on 14/08/2026.
//

import UIKit
import SkeletonView
import CustomButton
import CustomTextField

class CategoryListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var filterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filterButton.applyStyle(type: .borderButton, text: "Filter & Sorting")
        filterButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        
        searchTextField.applyStyle(type: .search, placeHolder: "Search Product Name")
        searchTextField.rightView?.isHidden = true

        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .offGrey
        
        collectionView.register(
            UINib(nibName: "DetailCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: DetailCollectionViewCell.reuseID
        )
        
        view.showAnimatedGradientSkeleton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.view.hideSkeleton()
            self?.searchTextField.rightView?.isHidden = false
        }
    }


}


extension CategoryListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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
        let padding: CGFloat = 16
        let spacing: CGFloat = 15
        let columns: CGFloat = 2
        let width = (collectionView.bounds.width - (padding * 2) - spacing) / columns
        return CGSize(width: width, height: width * 1.35)
    }

    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
}

extension CategoryListViewController: SkeletonCollectionViewDataSource {
    
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return DetailCollectionViewCell.reuseID
    }
}
