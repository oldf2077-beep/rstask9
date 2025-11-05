//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 15.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import UIKit

class ColorTableViewCell: UITableViewCell {
    private enum Constants {
        static let identifier = "ColorTableViewCell"
        static let fontSize: CGFloat = 16
        static let imageSize: CGFloat = 20
        static let horizontalMargin: CGFloat = 20
        static let imageSystemName = "checkmark"
    }
    
    static let identifier = Constants.identifier
    
    private let hexLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedSystemFont(ofSize: Constants.fontSize, weight: .regular)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let selectionImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: Constants.imageSystemName))
        image.tintColor = .red
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isHidden = true
        
        return image
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func configure(with item: ColorItem) {
        hexLabel.textColor = item.color
        hexLabel.text = item.hexCode
        selectionImage.isHidden = !item.isSelected
    }
}

private extension ColorTableViewCell {
    func setupUI() {
        selectionStyle = .none
        contentView.backgroundColor = .systemGray6
        
        horizontalStackView.backgroundColor = .white
        horizontalStackView.isLayoutMarginsRelativeArrangement = true
        horizontalStackView.layoutMargins = UIEdgeInsets(top: 0, left: Constants.horizontalMargin, bottom: 0, right: Constants.horizontalMargin)
        horizontalStackView.addArrangedSubview(hexLabel)
        horizontalStackView.addArrangedSubview(selectionImage)
        
        contentView.addSubview(horizontalStackView)
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalMargin),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalMargin),
            
            selectionImage.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            selectionImage.heightAnchor.constraint(equalToConstant: Constants.imageSize)
        ])
    }
}
