// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public class ImagePagerView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    var currentPageTintColor: UIColor = .white
    var pageTintColor: UIColor = .gray
    var imageContentMode: UIView.ContentMode = .scaleToFill
    var showsPageControl: Bool = true
        
    private var collectionView: UICollectionView!
    private let pageControl = UIPageControl()
    private let pageControlBackground = UIView()
    private var images: [UIImage] = []
    
    public var onUserInteractionBegan: (() -> Void)?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImagePagerCell.self, forCellWithReuseIdentifier: ImagePagerCell.reuseIdentifier)

        pageControlBackground.translatesAutoresizingMaskIntoConstraints = false
        pageControlBackground.backgroundColor = UIColor.gray.withAlphaComponent(0.35)
        pageControlBackground.layer.cornerRadius = 12

        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = currentPageTintColor
        pageControl.pageIndicatorTintColor = pageTintColor

        addSubview(collectionView)
        addSubview(pageControlBackground)
        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),

            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
           pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),

           pageControlBackground.centerXAnchor.constraint(equalTo: pageControl.centerXAnchor),
           pageControlBackground.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor),
           pageControlBackground.widthAnchor.constraint(equalTo: pageControl.widthAnchor),
           pageControlBackground.heightAnchor.constraint(equalToConstant: 23)
        ])
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = bounds.size
        }
    }

    public func configure(images: [UIImage]) {
        self.images = images

        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0

        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        collectionView.setContentOffset(.zero, animated: false)
    }

    public func advanceToNextPage() {
        guard !images.isEmpty else { return }
        let nextPage = (pageControl.currentPage + 1) % images.count
        collectionView.scrollToItem(at: IndexPath(item: nextPage, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = nextPage
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        onUserInteractionBegan?()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePagerCell.reuseIdentifier, for: indexPath) as! ImagePagerCell
        cell.configure(image: images[indexPath.item], contentMode: imageContentMode)
        return cell
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / max(scrollView.bounds.width, 1)))
        pageControl.currentPage = page
    }
}
