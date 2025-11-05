//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 12.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import UIKit

class ItemsViewController: UIViewController {
    private enum Constants {
        static let padding: CGFloat = 16
        static let spacing: CGFloat = 12
        static let itemHeightOffset: CGFloat = 40
        static let numberOfColumns: CGFloat = 2
    }
    
    private let viewModel: ItemViewModel
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let totalHorizontalPadding = Constants.padding * 2 + Constants.spacing
        let availableWidth = view.frame.width - totalHorizontalPadding
        let itemWidth = availableWidth / Constants.numberOfColumns
        
        layout.minimumLineSpacing = Constants.spacing
        layout.minimumInteritemSpacing = Constants.spacing
        layout.sectionInset = UIEdgeInsets(
            top: Constants.padding,
            left: Constants.padding,
            bottom: Constants.padding,
            right: Constants.padding
        )
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        return collectionView
    }()
    
    init(viewModel: ItemViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        
        setupCollection()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate { _ in
           self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}

extension ItemsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell else {
            fatalError("Unable to dequeue ItemCollectionViewCell")
        }
        cell.configure(with: viewModel.items[indexPath.item])
        return cell
    }
}

extension ItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalPadding = Constants.padding * 2 + Constants.spacing
        let availableWidth = collectionView.frame.width - totalPadding
        let itemWidth = availableWidth / Constants.numberOfColumns
        let itemHeight = itemWidth + Constants.itemHeightOffset
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension ItemsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.item]
        presentController(with: item)
    }
}

private extension ItemsViewController {
    func setupCollection() {
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func presentController(with item: Item) {
        let viewController: UIViewController
        
        switch item.type {
        case .story:
            viewController = StoryDetailsViewController(viewModel: StoryViewModel(with: item.id))
        case .gallery:
            viewController = GalleryDetailsViewController(viewModel: GalleryViewModel(with: item.id))
        }
        
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
}
