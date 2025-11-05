//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 13.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import UIKit

class ColorPickerViewController: UIViewController {
    private enum Constants {
        static let rowHeight: CGFloat = 50
        static let separatorLeftInset: CGFloat = 40
        static let separatorRightInset: CGFloat = 20
        static let backButtonTitle = "Settings"
    }
    
    private let viewModel: ColorPickerViewModel
    private let tableView = UITableView()
    
    init(viewModel: ColorPickerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.backButtonTitle = Constants.backButtonTitle
        
        setupTableView()
    }
}

extension ColorPickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.colorItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ColorTableViewCell.identifier, for: indexPath) as! ColorTableViewCell
        
        let item = viewModel.colorItems[indexPath.row]
        
        cell.configure(with: item)
        
        return cell
    }
}

extension ColorPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectColor(at: indexPath)
        SettingsManager.shared.currentSettings.strokeColor = viewModel.colorItems[indexPath.row].hexCode
        navigateBack()
    }
}

private extension ColorPickerViewController {
    func setupTableView() {
        let initialIndex = viewModel.selectedColorIndex()
        selectColor(at: IndexPath(row: initialIndex, section: .zero))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: ColorTableViewCell.identifier)

        tableView.rowHeight = Constants.rowHeight
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .systemGray6
        tableView.separatorInset = UIEdgeInsets(top: 0, left: Constants.separatorLeftInset, bottom: 0, right: Constants.separatorRightInset)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func selectColor(at indexPath: IndexPath) {
        let result = viewModel.selectColor(at: indexPath.row)

        if let previousIndex = result.previousIndex {
            tableView.reloadRows(at: [IndexPath(row: previousIndex, section: indexPath.section)], with: .automatic)
        }
        
        tableView.reloadRows(at: [IndexPath(row: result.currentIndex, section: indexPath.section)], with: .automatic)
    }
    
    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}
