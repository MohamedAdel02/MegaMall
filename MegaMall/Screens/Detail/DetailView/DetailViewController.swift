//
//  DetailViewController.swift
//  MegaMall
//
//  Created by Mohamed Adel on 11/08/2026.
//

import UIKit
import SwiftUI
import SkeletonView

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var config = addedButton.configuration ?? UIButton.Configuration.plain()
        config.imagePlacement = .trailing
        config.imagePadding = 8
        addedButton.configuration = config
        
        tableView.sectionHeaderTopPadding = 0
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
                
        tableView.showsVerticalScrollIndicator = false

        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCell.reuseID)
        tableView.register(UINib(nibName: "SellerTableViewCell", bundle: nil), forCellReuseIdentifier: SellerTableViewCell.reuseID)
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: DescriptionTableViewCell.reuseID)
        tableView.register(UINib(nibName: "ReviewsTableViewCell", bundle: nil), forCellReuseIdentifier: ReviewsTableViewCell.reuseID)
        tableView.register(UINib(nibName: "ReusableTableViewCell", bundle: nil), forCellReuseIdentifier: ReusableTableViewCell.reuseID)
        
        view.showAnimatedGradientSkeleton(transition: .none)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.view.hideSkeleton()
        }
    }
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 3 ? 3 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TitleTableViewCell.reuseID,
                for: indexPath
            ) as? TitleTableViewCell else {
                return UITableViewCell()
            }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SellerTableViewCell.reuseID,
                for: indexPath
            ) as? SellerTableViewCell else {
                return UITableViewCell()
            }
            return cell

        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DescriptionTableViewCell.reuseID,
                for: indexPath
            ) as? DescriptionTableViewCell else {
                return UITableViewCell()
            }
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ReviewsTableViewCell.reuseID,
                for: indexPath
            ) as? ReviewsTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ReusableTableViewCell.reuseID,
                for: indexPath
            ) as? ReusableTableViewCell else {
                return UITableViewCell()
            }
            return cell

        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
            return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 3 else { return nil }
        
        return ReviewsCellHeader()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 3 ? 60 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section == 3 else { return nil }
        
        return ReviewsCellFooter()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 3 ? 70 : 0
    }
    
}


extension DetailViewController: SkeletonTableViewDataSource {
    
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 3 ? 3 : 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch indexPath.section {
        case 0: return TitleTableViewCell.reuseID
        case 1: return SellerTableViewCell.reuseID
        case 2: return DescriptionTableViewCell.reuseID
        case 3: return ReviewsTableViewCell.reuseID
        case 4: return ReusableTableViewCell.reuseID
        default: return TitleTableViewCell.reuseID
        }
    }
}

#Preview {
    DetailViewController()
}

