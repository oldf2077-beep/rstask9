//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 14.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import UIKit

class DrawStroiesCollectionViewCell: UITableViewCell {
    private enum Constants {
        static let identifier = "DrawStroiesCollectionViewCell"
        static let horizontalMargin: CGFloat = 20
        static let labelText = "Draw stories"
        static let labelFontSize: CGFloat = 16
        static let labelFontWeight: UIFont.Weight = .medium
    }
    
    static let identifier = Constants.identifier
    
    let uiSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        
        return uiSwitch
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
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    public func addSwitch(uiSwitch: UISwitch) {
        horizontalStackView.addArrangedSubview(uiSwitch)
    }
    
    private func setupCell() {
        contentView.backgroundColor = .systemGray6
        selectionStyle = .none
        
        horizontalStackView.backgroundColor = .white
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.isLayoutMarginsRelativeArrangement = true
        horizontalStackView.layoutMargins = UIEdgeInsets(
            top: 0,
            left: Constants.horizontalMargin,
            bottom: 0,
            right: Constants.horizontalMargin
        )
        
        let drawStoriesLabel = UILabel()
        drawStoriesLabel.text = Constants.labelText
        drawStoriesLabel.tintColor = .black
        drawStoriesLabel.font = UIFont.systemFont(
            ofSize: Constants.labelFontSize,
            weight: Constants.labelFontWeight
        )
        drawStoriesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalStackView.addArrangedSubview(drawStoriesLabel)
        horizontalStackView.addArrangedSubview(uiSwitch)
        contentView.addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalMargin),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalMargin),
        ])
    }
}
