//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 15.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    private enum Constants {
        static let identifier = "ItemCollectionViewCell"
        static let titleFontSize: CGFloat = 16
        static let titleFontWeight: UIFont.Weight = .semibold
        static let subtitleFontSize: CGFloat = 12
        static let subtitleFontWeight: UIFont.Weight = .semibold
        static let borderWidth: CGFloat = 1.0
        static let cornerRadius: CGFloat = 10
        static let stackViewSpacing: CGFloat = 2
        static let imageViewInset: CGFloat = 10
        static let textStackViewLeftMargin: CGFloat = 8
        static let textStackViewBottomMargin: CGFloat = 8
        static let textStackViewTrailingMargin: CGFloat = 10
    }
    
    static let identifier = Constants.identifier
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(
            ofSize: Constants.titleFontSize,
            weight: Constants.titleFontWeight
        )
        title.textColor = .white
        title.lineBreakMode = .byTruncatingTail
        
        return title
    }()
    
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: Constants.subtitleFontSize,
            weight: Constants.subtitleFontWeight
        )
        label.textColor = .white
        
        return label
    }()
    
    private lazy var coverImageView = GradientUIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeSubtitleText(text: String) {
        subtitleLabel.text = text
    }
    
    func configure(with item: Item) {
        titleLabel.text = item.title
        subtitleLabel.text = item.type.rawValue
        coverImageView.image = UIImage(named: item.coverImage)
    }
}

private extension ItemCollectionViewCell {
    func setupCell() {
        backgroundColor = .white
        contentView.layer.borderWidth = Constants.borderWidth
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = Constants.cornerRadius
        
        // Вертикальный StackView для текста
        let textStackView = UIStackView()
        textStackView.axis = .vertical
        textStackView.distribution = .fillEqually
        textStackView.alignment = .leading
        textStackView.spacing = Constants.stackViewSpacing
        
        // Собираем вертикальный StackView
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subtitleLabel)
        textStackView.isLayoutMarginsRelativeArrangement = true
        textStackView.layoutMargins = UIEdgeInsets(
            top: 0,
            left: Constants.textStackViewLeftMargin,
            bottom: Constants.textStackViewBottomMargin,
            right: 0
        )
        
        coverImageView.addSubview(textStackView)
        addSubview(coverImageView)
        
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.imageViewInset),
            coverImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.imageViewInset),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.imageViewInset),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.imageViewInset),
            
            textStackView.bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor),
            textStackView.leadingAnchor.constraint(equalTo: coverImageView.leadingAnchor),
            textStackView.trailingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: -Constants.textStackViewTrailingMargin)
        ])
    }
}
