//
//  UIViewFromNib.swift
//  MegaMall
//
//  Created by Mohamed Adel on 12/08/2026.
//


import UIKit

class UIViewFromNib: UIView {

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commitInit()
    }

    private func commitInit() {
        let nibName = String(describing: Self.self)
        let bundle = Bundle(for: Self.self)
        let nibFile = UINib(nibName: nibName, bundle: bundle)
        guard let contentView = nibFile.instantiate(withOwner: self).first as? UIView else {
            assertionFailure("Unable to load nib named \(nibName) as \(Self.self)")
            return
        }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

