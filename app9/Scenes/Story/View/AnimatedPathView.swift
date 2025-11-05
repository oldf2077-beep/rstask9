//
// 📰 🐸 
// Project: app9
// 
// Author: akote
// On: 31.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import UIKit

class AnimatedPathView: UIView {
    private enum Constants {
        static let defaultAnimationDuration: TimeInterval = 3.0
        static let lineWidth: CGFloat = 1.0
        static let strokeEndStart: CGFloat = 0.0
        static let strokeEndFinish: CGFloat = 1.0
    }
    
    private var path: CGPath?
    private var shapeLayer: CAShapeLayer?
    private var animationDuration: TimeInterval = Constants.defaultAnimationDuration
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    func setPath(_ path: CGPath, animated: Bool = true) {
        self.path = path

        shapeLayer?.removeFromSuperlayer()

        let newShapeLayer = CAShapeLayer()
        newShapeLayer.path = path
        newShapeLayer.fillColor = UIColor.clear.cgColor
        newShapeLayer.strokeColor = UIColor(hexString: SettingsManager.shared.currentSettings.strokeColor)?.cgColor
        newShapeLayer.lineWidth = Constants.lineWidth
        newShapeLayer.lineCap = .round
        newShapeLayer.lineJoin = .round
        
        layer.addSublayer(newShapeLayer)
        shapeLayer = newShapeLayer
        
        if animated {
            animatePath()
        } else {
            shapeLayer?.strokeEnd = Constants.strokeEndFinish
        }
    }
    
    private func animatePath() {
        guard let shapeLayer = shapeLayer else { return }

        shapeLayer.strokeEnd = Constants.strokeEndStart

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = Constants.strokeEndStart
        animation.toValue = Constants.strokeEndFinish
        animation.duration = animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        shapeLayer.add(animation, forKey: "pathAnimation")

        shapeLayer.strokeEnd = Constants.strokeEndFinish
    }
    
    func setAnimationDuration(_ duration: TimeInterval) {
        animationDuration = duration
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer?.frame = bounds
    }
}
