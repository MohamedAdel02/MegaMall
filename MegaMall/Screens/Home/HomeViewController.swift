//
//  HomeViewController.swift
//  MegaMall
//
//  Created by Mohamed Adel on 15/08/2026.
//

import UIKit
import SkeletonView
import CustomTextField

class HomeViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.applyStyle(type: .search, placeHolder: "Search Product Name")

        tableView.sectionHeaderTopPadding = 0
        tableView.dataSource = self
        tableView.delegate = self

        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false


        tableView.register(UINib(nibName: "BannerTableViewCell", bundle: nil), forCellReuseIdentifier: BannerTableViewCell.reuseID)
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: CategoryTableViewCell.reuseID)
        tableView.register(UINib(nibName: "ReusableTableViewCell", bundle: nil), forCellReuseIdentifier: ReusableTableViewCell.reuseID)
        tableView.register(UINib(nibName: "LatestNewsTableViewCell", bundle: nil), forCellReuseIdentifier: LatestNewsTableViewCell.reuseID)

        view.showAnimatedGradientSkeleton(transition: .none)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.view.hideSkeleton()
            
            if let bannerCell = self?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? BannerTableViewCell {
                    bannerCell.stopSkeletonAnimations()
                }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 7 ? 3 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BannerTableViewCell.reuseID,
                for: indexPath
            ) as? BannerTableViewCell else {
                return UITableViewCell()
            }

            return cell

        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryTableViewCell.reuseID,
                for: indexPath
            ) as? CategoryTableViewCell else {
                return UITableViewCell()
            }

            return cell

        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ReusableTableViewCell.reuseID,
                for: indexPath
            ) as? ReusableTableViewCell else {
                return UITableViewCell()
            }

            cell.bannerView.isHidden = false
            cell.sectionLabel.text = "Featured Product"
            return cell

        case 3:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ReusableTableViewCell.reuseID,
                for: indexPath
            ) as? ReusableTableViewCell else {
                return UITableViewCell()
            }

            cell.bannerView.isHidden = false
            cell.bannerView.backgroundColor = .redVelvet
            cell.sectionLabel.text = "Best Sellers"
            return cell

        case 4:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ReusableTableViewCell.reuseID,
                for: indexPath
            ) as? ReusableTableViewCell else {
                return UITableViewCell()
            }

            cell.sectionLabel.text = "New Arrivals"
            return cell

        case 5:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ReusableTableViewCell.reuseID,
                for: indexPath
            ) as? ReusableTableViewCell else {
                return UITableViewCell()
            }

            cell.sectionLabel.text = "Top Rated Product"
            return cell

        case 6:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ReusableTableViewCell.reuseID,
                for: indexPath
            ) as? ReusableTableViewCell else {
                return UITableViewCell()
            }

            cell.sectionLabel.text = "Special Offers"
            return cell

        case 7:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: LatestNewsTableViewCell.reuseID,
                for: indexPath
            ) as? LatestNewsTableViewCell else {
                return UITableViewCell()
            }

            return cell

        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 7 else { return nil }
        return LatestNewsHeader()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 7 ? 50 : 0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section == 7 else { return nil }
        return LatestNewsFooter()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 7 ? 85 : 0
    }
}



extension HomeViewController: SkeletonTableViewDataSource {

    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 8
    }

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 7 ? 3 : 1
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch indexPath.section {
        case 0: return BannerTableViewCell.reuseID
        case 1: return CategoryTableViewCell.reuseID
        case 2: return ReusableTableViewCell.reuseID
        case 3: return ReusableTableViewCell.reuseID
        case 4: return ReusableTableViewCell.reuseID
        case 5: return ReusableTableViewCell.reuseID
        case 6: return ReusableTableViewCell.reuseID
        case 7: return LatestNewsTableViewCell.reuseID
        default: return ReusableTableViewCell.reuseID
        }
    }
}

#Preview {
    HomeViewController()
}

