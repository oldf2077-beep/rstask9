//
// 📰 🐸
// Project: RSSchool_T9
//
// Author: akote
// On: 13.10.25
//
// Copyright © 2025 RSSchool. All rights reserved.

import UIKit

class StrokeColorCollectionViewCell: UITableViewCell {
    private enum Constants {
        static let identifier = "StrokeColorCollectionViewCell"
        static let subtitleFontSize: CGFloat = 12
        static let titleFontSize: CGFloat = 16
        static let horizontalMargin: CGFloat = 20
        static let textStackViewSpacing: CGFloat = 1
        static let titleText = "Stroke color"
    }
    
    static let identifier = Constants.identifier
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = SettingsManager.shared.currentSettings.strokeColor
        label.font = UIFont.systemFont(ofSize: Constants.subtitleFontSize, weight: .regular)
        label.textColor = .red
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    func changeSubtitleText(text: String, textColor: UIColor) {
        subtitleLabel.text = text
        subtitleLabel.textColor = textColor
    }
    
    func setupCell() {
        backgroundColor = .systemGray6
        self.selectionStyle = .none
        
        // Главный горизонтальный StackView
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.distribution = .equalSpacing
        mainStackView.alignment = .center
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.backgroundColor = .white
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = UIEdgeInsets(top: 0, left: Constants.horizontalMargin, bottom: 0, right: Constants.horizontalMargin)
        
        // Вертикальный StackView для текста
        let textStackView = UIStackView()
        textStackView.axis = .vertical
        textStackView.distribution = .equalSpacing
        textStackView.alignment = .leading
        textStackView.spacing = Constants.textStackViewSpacing
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Элементы
        let titleLabel = UILabel()
        titleLabel.text = Constants.titleText
        titleLabel.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let chevron = UIImageView(image: UIImage(systemName: "chevron.forward"))
        chevron.tintColor = .gray
        chevron.translatesAutoresizingMaskIntoConstraints = false
        
        // Собираем вертикальный StackView
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subtitleLabel)
        
        // Собираем главный StackView
        mainStackView.addArrangedSubview(textStackView)
        mainStackView.addArrangedSubview(chevron)

        contentView.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalMargin),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalMargin),
        ])
    }
}
