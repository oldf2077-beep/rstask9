//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 25.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import UIKit

class GalleryDetailsViewController: DismissViewController {
    private enum Constants {
        static let titleViewTopMargin: CGFloat = 40
        static let titleViewHorizontalMargin: CGFloat = 20
        static let titleViewHeight: CGFloat = 520
        static let coverImageBottomMargin: CGFloat = -20
        static let titleLabelHorizontalMargin: CGFloat = 20
        static let titleLabelBottomMargin: CGFloat = -40
        static let titleTypeLabelWidth: CGFloat = 140
        static let titleTypeLabelHeight: CGFloat = 40
        static let dividerHeight: CGFloat = 1
        static let dividerTopMargin: CGFloat = 30
        static let dividerHorizontalMargin: CGFloat = 80
        static let imageContentViewTopMargin: CGFloat = 20
        static let collectionViewTopMargin: CGFloat = 20
        static let titleFontSize: CGFloat = 50
        static let titleTypeFontSize: CGFloat = 30
        static let titleTypeLabelText = "Gallery"
        static let collectionViewSpacing: CGFloat = 10
        static let cellHeight: CGFloat = 400
        static let collectionViewPadding: CGFloat = 40
        static let cellHeightMultiplier: CGFloat = 200
        static let cellHeightMultiplierFactor: CGFloat = 2
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 1
    }
    
    private var viewModel: GalleryViewModel!
    
    private lazy var titleView = UIView()
    
    private lazy var coverImageView: GradientUIImageView = {
        let coverImage = GradientUIImageView()
        coverImage.layer.borderColor = UIColor.white.cgColor
        
        return coverImage
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: Constants.titleFontSize, weight: .semibold)
        title.text = ""
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
    
    private lazy var imageContentView = UIView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = Constants.collectionViewSpacing
        layout.minimumLineSpacing = Constants.collectionViewSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.alwaysBounceVertical = false
        
        return collectionView
    }()

    init(viewModel: GalleryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil,bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        addSubviews()
        setupConstraints()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupGallery()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension GalleryDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel.gallery?.content.count ?? 0
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryImageCell.identifier, for: indexPath) as! GalleryImageCell
        
        if let gallery = viewModel.gallery {
            if let image = UIImage(named: gallery.content[indexPath.item]) {
                cell.configure(with: image)
            }
        }
        
        return cell
    }
}

extension GalleryDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - Constants.collectionViewPadding
        let cellWidth = availableWidth
        return CGSize(width: cellWidth, height: Constants.cellHeightMultiplierFactor * Constants.cellHeightMultiplier)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.collectionViewSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.collectionViewSpacing
    }
}

extension GalleryDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let image = UIImage(named: viewModel.gallery?.content[indexPath.item] ?? "") else { return }
        let viewModel = ImageViewModel(image: image)
        let imageDetailsViewController = ImageDetailsViewController(viewModel: viewModel)
        imageDetailsViewController.modalPresentationStyle = .overFullScreen
        present(imageDetailsViewController, animated: true)
    }
}

private extension GalleryDetailsViewController {
    func addSubviews() {
        contentView.addSubview(titleView)
        titleView.addSubview(coverImageView)
        titleView.addSubview(titleTypeLabel)
        contentView.addSubview(dividerView)
        coverImageView.addSubview(titleLabel)
        contentView.addSubview(imageContentView)
        imageContentView.addSubview(collectionView)
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GalleryImageCell.self, forCellWithReuseIdentifier: GalleryImageCell.identifier)
    }
    
    func setupConstraints() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        imageContentView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
            
            imageContentView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: Constants.imageContentViewTopMargin),
            imageContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageContentView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            collectionView.topAnchor.constraint(equalTo: imageContentView.topAnchor, constant: Constants.collectionViewTopMargin),
            collectionView.leadingAnchor.constraint(equalTo: imageContentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: imageContentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: imageContentView.bottomAnchor)
        ])
    }
    
    func setupGallery() {
        if let gallery = viewModel.gallery {
            coverImageView.image = UIImage(named: gallery.coverImage)
            titleLabel.text = gallery.title
           
            collectionView.reloadData()
         
            updateCollectionViewHeight(with: gallery.content.count)
        }
    }
    
    func updateCollectionViewHeight(with galleryCount: Int) {
        let totalHeight = CGFloat(galleryCount) * (Constants.cellHeight + Constants.collectionViewSpacing)
        
        collectionView.removeConstraints(collectionView.constraints.filter { $0.firstAttribute == .height })
        collectionView.heightAnchor.constraint(equalToConstant: totalHeight).isActive = true
    }
}
