//
//  TitleTableViewCell.swift
//  MegaMall
//
//  Created by Mohamed Adel on 11/08/2026.
//

import UIKit
import ImagePager

class TitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var numOfReviewsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    private let pager = ImagePagerView()
    private var pagerTimer: Timer?
    
    static let reuseID = "TitleTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pager.translatesAutoresizingMaskIntoConstraints = false
                productImageView.addSubview(pager)

        NSLayoutConstraint.activate([
            pager.topAnchor.constraint(equalTo: productImageView.topAnchor),
            pager.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            pager.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            pager.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor)
        ])

        pager.configure(images: [.headPhones, .something, .wireWithBackground])
        
        availabilityLabel.layer.cornerRadius = 13
        availabilityLabel.layer.masksToBounds = true
        
        startPagerTimer()
        
        pager.onUserInteractionBegan = { [weak self] in
            self?.stopPagerTimer()
        }
        
    }

    private func startPagerTimer() {
        stopPagerTimer()
        pagerTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.pager.advanceToNextPage()
        }
    }

    private func stopPagerTimer() {
        pagerTimer?.invalidate()
        pagerTimer = nil
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none

    }
    
}

