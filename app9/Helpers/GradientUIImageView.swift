//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 24.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import UIKit

class GradientUIImageView: UIImageView {
    private enum Constants {
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 10
        static let gradientStartPoint: CGPoint = CGPoint(x: 0.0, y: 0.9)
        static let gradientEndPoint: CGPoint = CGPoint(x: 0.0, y: 0.5)
        static let gradientAlpha: CGFloat = 0.8
    }
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = Constants.borderWidth
        layer.cornerRadius = Constants.cornerRadius
        
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(Constants.gradientAlpha).cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.startPoint = Constants.gradientStartPoint
        gradientLayer.endPoint = Constants.gradientEndPoint
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
