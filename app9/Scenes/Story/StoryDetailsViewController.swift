//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 18.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import UIKit

class StoryDetailsViewController: DismissViewController {
    private enum Constants {
        static let titleViewTopMargin: CGFloat = 40
        static let titleViewHorizontalMargin: CGFloat = 20
        static let titleViewHeight: CGFloat = 520
        static let coverImageBottomMargin: CGFloat = -20
        static let titleLabelHorizontalMargin: CGFloat = 20
        static let titleLabelBottomMargin: CGFloat = -40
        static let titleTypeLabelWidth: CGFloat = 120
        static let titleTypeLabelHeight: CGFloat = 40
        static let dividerHeight: CGFloat = 1
        static let dividerTopMargin: CGFloat = 30
        static let dividerHorizontalMargin: CGFloat = 80
        static let pathsScrollViewTopMargin: CGFloat = 20
        static let pathsScrollViewHorizontalMargin: CGFloat = 40
        static let pathsScrollViewHeight: CGFloat = 100
        static let textContentViewTopMargin: CGFloat = 20
        static let contentLabelMargin: CGFloat = 20
        static let pathViewWidth: CGFloat = 150
        static let pathViewLeadingMargin: CGFloat = 70
        static let pathViewTrailingMargin: CGFloat = 20
        static let titleFontSize: CGFloat = 50
        static let titleTypeFontSize: CGFloat = 30
        static let contentFontSize: CGFloat = 16
        static let titleTypeLabelText = "Story"
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 1
    }
    
    private var viewModel: StoryViewModel!
    
    private lazy var titleView = UIView()
    
    private lazy var coverImageView: GradientUIImageView = {
        let coverImage = GradientUIImageView()
        coverImage.layer.borderColor = UIColor.white.cgColor
        
        return coverImage
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: Constants.titleFontSize, weight: .semibold)
        title.textColor = .white
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        
        return title
    }()
    
    private lazy var titleTypeLabel: UILabel = {
        let title = UILabel()
        title.text = Constants.titleTypeLabelText
        title.textColor = .white
        title.font = .systemFont(ofSize: Constants.titleTypeFontSize, weight: .bold)
        title.layer.cornerRadius = Constants.cornerRadius
        title.layer.borderWidth = Constants.borderWidth
        title.layer.borderColor = UIColor.white.cgColor
        title.backgroundColor = .black
        title.clipsToBounds = true
        title.textAlignment = .center
        
        return title
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = Constants.borderWidth
        
        return view
    }()
    
    private lazy var textContentView: UIView = {
        let view = UIView()
        view.layer.borderWidth = Constants.borderWidth
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.borderColor = UIColor.white.cgColor
        
        return view
    }()
    
    private lazy var contentLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: Constants.contentFontSize, weight: .semibold)
        title.textColor = .white
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        
        return title
    }()
    
    private lazy var pathsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.backgroundColor = .clear
        
        return scrollView
    }()
    
    private lazy var pathsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = Constants.borderWidth
        
        return view
    }()
    
    init(viewModel: StoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil,bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        addSubViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupStory()
    }
}

private extension StoryDetailsViewController {
    func addSubViews() {
        contentView.addSubview(titleView)
        titleView.addSubview(coverImageView)
        titleView.addSubview(titleTypeLabel)
        contentView.addSubview(dividerView)
        coverImageView.addSubview(titleLabel)
        contentView.addSubview(pathsScrollView)
        pathsScrollView.addSubview(pathsContainerView)
        contentView.addSubview(textContentView)
        contentView.addSubview(contentLabel)
    }
    
    func setupConstraints() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        pathsScrollView.translatesAutoresizingMaskIntoConstraints = false
        pathsContainerView.translatesAutoresizingMaskIntoConstraints = false
        textContentView.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.titleViewTopMargin),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleViewHorizontalMargin),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.titleViewHorizontalMargin),
            titleView.heightAnchor.constraint(equalToConstant: Constants.titleViewHeight),
            
            coverImageView.topAnchor.constraint(equalTo: titleView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.coverImageBottomMargin),
            
            titleLabel.leadingAnchor.constraint(equalTo: coverImageView.leadingAnchor, constant: Constants.titleLabelHorizontalMargin),
            titleLabel.trailingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: -Constants.titleLabelHorizontalMargin),
            titleLabel.bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: Constants.titleLabelBottomMargin),
            
            titleTypeLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleTypeLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            titleTypeLabel.widthAnchor.constraint(equalToConstant: Constants.titleTypeLabelWidth),
            titleTypeLabel.heightAnchor.constraint(equalToConstant: Constants.titleTypeLabelHeight),
            
            dividerView.heightAnchor.constraint(equalToConstant: Constants.dividerHeight),
            dividerView.topAnchor.constraint(equalTo: titleTypeLabel.bottomAnchor, constant: Constants.dividerTopMargin),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.dividerHorizontalMargin),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.dividerHorizontalMargin),
            
            pathsScrollView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: Constants.pathsScrollViewTopMargin),
            pathsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.pathsScrollViewHorizontalMargin),
            pathsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.pathsScrollViewHorizontalMargin),
            pathsScrollView.heightAnchor.constraint(equalToConstant: Constants.pathsScrollViewHeight),
            
            pathsContainerView.topAnchor.constraint(equalTo: pathsScrollView.topAnchor),
            pathsContainerView.bottomAnchor.constraint(equalTo: pathsScrollView.bottomAnchor),
            pathsContainerView.centerXAnchor.constraint(equalTo: pathsScrollView.centerXAnchor),
            
            textContentView.topAnchor.constraint(equalTo: pathsScrollView.bottomAnchor, constant: Constants.textContentViewTopMargin),
            textContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textContentView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: textContentView.topAnchor, constant: Constants.contentLabelMargin),
            contentLabel.leadingAnchor.constraint(equalTo: textContentView.leadingAnchor, constant: Constants.contentLabelMargin),
            contentLabel.trailingAnchor.constraint(equalTo: textContentView.trailingAnchor, constant: -Constants.contentLabelMargin),
            contentLabel.bottomAnchor.constraint(equalTo: textContentView.bottomAnchor, constant: -Constants.contentLabelMargin)
        ])
    }
    
    func setupStory() {
        if let story = viewModel.story {
            coverImageView.image = UIImage(named: story.coverImage)
            titleLabel.text = story.title
            contentLabel.text = story.content
            
            setupAnimatedPaths(story.path)
        }
    }
    
    func setupAnimatedPaths(_ paths: [CGPath]) {
        pathsContainerView.subviews.forEach { $0.removeFromSuperview() }
        
        guard !paths.isEmpty else { return }
        
        var previousView: UIView?
        
        for path in paths {
            let pathView = AnimatedPathView()
            pathView.setPath(path, animated: SettingsManager.shared.currentSettings.isDrawStories)
            
            pathView.setAnimationDuration(3.0)
            
            pathView.translatesAutoresizingMaskIntoConstraints = false
            
            pathsContainerView.addSubview(pathView)
            
            NSLayoutConstraint.activate([
                pathView.topAnchor.constraint(equalTo: pathsContainerView.topAnchor),
                pathView.bottomAnchor.constraint(equalTo: pathsContainerView.bottomAnchor),
                pathView.widthAnchor.constraint(equalToConstant: Constants.pathViewWidth),
                pathView.heightAnchor.constraint(equalTo: pathsContainerView.heightAnchor)
            ])
            
            if let previous = previousView {
                pathView.leadingAnchor.constraint(equalTo: previous.trailingAnchor).isActive = true
            } else {
                pathView.leadingAnchor.constraint(equalTo: pathsContainerView.leadingAnchor, constant: Constants.pathViewLeadingMargin).isActive = true
            }
            
            previousView = pathView
        }
        if let lastView = previousView {
            pathsContainerView.trailingAnchor.constraint(equalTo: lastView.trailingAnchor, constant: Constants.pathViewTrailingMargin).isActive = true
        }
    }
}
