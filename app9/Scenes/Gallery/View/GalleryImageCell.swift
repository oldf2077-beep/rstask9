//
// 📰 🐸 
// Project: app9
// 
// Author: akote
// On: 31.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import UIKit

class GalleryImageCell: UICollectionViewCell {
    private enum Constants {
        static let identifier = "GalleryImageCell"
        static let imageViewCornerRadius: CGFloat = 8
        static let contentViewCornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 1
        static let imageViewInset: CGFloat = 10
    }
    
    static let identifier = Constants.identifier
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.imageViewCornerRadius
        imageView.backgroundColor = .systemGray5
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

private extension GalleryImageCell {
    func setupUI() {
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.borderWidth = Constants.borderWidth
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.imageViewInset),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.imageViewInset),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.imageViewInset),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.imageViewInset)
        ])
    }
}
