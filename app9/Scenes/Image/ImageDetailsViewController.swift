//
// 📰 🐸 
// Project: app9
// 
// Author: akote
// On: 26.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import UIKit

class ImageDetailsViewController: UIViewController {
    private enum Constants {
        static let exitButtonSize: CGFloat = 40
        static let exitButtonTop: CGFloat = 30
        static let exitButtonTrailing: CGFloat = -25
        static let exitButtonImageName = "x.circle"
        static let minimumZoomScale: CGFloat = 1.0
        static let maximumZoomScale: CGFloat = 3.0
    }
    
    private let viewModel: ImageViewModel
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    
    lazy var exitButton: UIButton = {
        let exit = UIButton()
        exit.setImage(UIImage(systemName: Constants.exitButtonImageName), for: .normal)
        exit.tintColor = .white
        exit.imageView?.contentMode = .scaleAspectFill
        exit.contentHorizontalAlignment = .fill
        exit.contentVerticalAlignment = .fill
        return exit
    }()
    
    init(viewModel: ImageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        exitButton.addTarget(self, action: #selector(exitButtonAction(_:)), for: .touchUpInside)
        loadImage()
        setupUI()
    }
    
    func loadImage() {
        imageView.image = viewModel.image
    }
}

extension ImageDetailsViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

private extension ImageDetailsViewController {
    func setupUI() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = Constants.minimumZoomScale
        scrollView.maximumZoomScale = Constants.maximumZoomScale
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = true
        scrollView.bouncesZoom = true
        
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        view.addSubview(exitButton)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGesture)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            exitButton.heightAnchor.constraint(equalToConstant: Constants.exitButtonSize),
            exitButton.widthAnchor.constraint(equalToConstant: Constants.exitButtonSize),
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.exitButtonTopMargin),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.exitButtonTrailingMargin),
            
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
    }
    
    @objc func imageTapped() {
        exitButton.isEnabled.toggle()
        if exitButton.isEnabled {
            exitButton.tintColor = .white
        } else {
            exitButton.tintColor = .black
        }
    }
    
    @objc func exitButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
