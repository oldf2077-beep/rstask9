//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 24.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import UIKit

class DismissViewController: UIViewController {
    private enum Constants {
        static let dismissIndicatorAlpha: CGFloat = 0.3
        static let dismissIndicatorCornerRadius: CGFloat = 2.5
        static let contentViewCornerRadius: CGFloat = 10
        static let dismissIndicatorTopOffset: CGFloat = 8
        static let dismissIndicatorWidth: CGFloat = 36
        static let dismissIndicatorHeight: CGFloat = 5
        static let dismissThreshold: CGFloat = 100
        static let dismissVelocityThreshold: CGFloat = 500
        static let animationDuration: TimeInterval = 0.3
        static let springDamping: CGFloat = 0.8
    }
    
    lazy var contentView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.keyboardDismissMode = .interactive
        view.bounces = false
        view.isDirectionalLockEnabled = true
        view.delaysContentTouches = false
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.cornerRadius = Constants.contentViewCornerRadius
        
        return view
    }()
    
    private var panGesture: UIPanGestureRecognizer!
    private var initialTouchPoint: CGPoint = CGPoint.zero
    
    private lazy var dismissIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(Constants.dismissIndicatorAlpha)
        view.layer.cornerRadius = Constants.dismissIndicatorCornerRadius
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        setupContentView()
        setupCustomDismissGesture()
        setupDismissIndicator()
    }
}

extension DismissViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGesture {
            guard contentView.contentOffset.y <= .zero else {
                return false
            }
            
            let velocity = panGesture.velocity(in: view)

            return velocity.y > .zero && abs(velocity.x) < abs(velocity.y)
        }
        return true
    }
}

private extension DismissViewController {
    func setupContentView() {
        contentView.backgroundColor = .black
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupDismissIndicator() {
        contentView.addSubview(dismissIndicator)
        
        dismissIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.dismissIndicatorTopOffset),
            dismissIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dismissIndicator.widthAnchor.constraint(equalToConstant: Constants.dismissIndicatorWidth),
            dismissIndicator.heightAnchor.constraint(equalToConstant: Constants.dismissIndicatorHeight)
        ])
    }

    func setupCustomDismissGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let touchPoint = gesture.location(in: view.window)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .began:
            initialTouchPoint = touchPoint
            
        case .changed:
            let deltaY = touchPoint.y - initialTouchPoint.y
            
            if deltaY > .zero {
                contentView.transform = CGAffineTransform(translationX: .zero, y: deltaY)
            }
            
        case .ended, .cancelled:
            let deltaY = touchPoint.y - initialTouchPoint.y
            
            if deltaY > Constants.dismissThreshold || velocity.y > Constants.dismissVelocityThreshold {
                dismiss(animated: true)
            } else {
                UIView.animate(withDuration: Constants.animationDuration, delay: .zero, usingSpringWithDamping: Constants.springDamping, initialSpringVelocity: .zero, options: .curveEaseOut) {
                    self.contentView.transform = .identity
                }
            }
            
        default:
            break
        }
    }
}
