//
//  StarRatingView.swift
//  MegaMall
//
//  Created by Mohamed Adel on 12/08/2026.
//

import UIKit

    class StarRatingView: UIView {

    var rating: Int = 0

    private let stackView = UIStackView()
    private var starImageViews: [UIImageView] = []
    private let maxRating = 5
    private let starSize: CGFloat = 20

    init(rating: Int) {
        super.init(frame: .zero)
        setupStars()
        self.rating = rating
        updateStars()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStars()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStars()
    }

    private func setupStars() {
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        for _ in 0..<maxRating {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.widthAnchor.constraint(equalToConstant: starSize).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: starSize).isActive = true
            stackView.addArrangedSubview(imageView)
            starImageViews.append(imageView)
        }
    }

    private func updateStars() {
        for (index, imageView) in starImageViews.enumerated() {
            if index < rating {
              let img = UIImage(systemName: "star.fill")
              imageView.image = img
              imageView.tintColor = .systemYellow
            } else {
              imageView.image = UIImage(systemName: "star")
              imageView.tintColor = .systemGray4
            }
        }
    }
        
}
