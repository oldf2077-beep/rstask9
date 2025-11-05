//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 13.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import UIKit

class SettingsViewController: UIViewController {
    private enum Constants {
        static let rowHeight: CGFloat = 50
        static let separatorLeftInset: CGFloat = 40
        static let separatorRightInset: CGFloat = 20
        static let navigationTitle = "Settings"
    }
    
    private enum SettingsType: CaseIterable {
        case switcher
        case color
    }
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        SettingsManager.shared.currentSettings.isDrawStories = sender.isOn
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SettingsType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SettingsType.allCases[indexPath.row] {
        case .switcher:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DrawStroiesCollectionViewCell.identifier, for: indexPath) as? DrawStroiesCollectionViewCell else {
                fatalError("Unable to dequeue DrawStroiesCollectionViewCell")
            }
            cell.uiSwitch.isOn = SettingsManager.shared.currentSettings.isDrawStories
            cell.uiSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
            
            return cell
        case .color:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StrokeColorCollectionViewCell.identifier, for: indexPath) as? StrokeColorCollectionViewCell else {
                fatalError("Unable to dequeue StrokeColorCollectionViewCell")
            }
            let strokeColor = SettingsManager.shared.currentSettings.strokeColor
            let textColor = UIColor(hexString: strokeColor) ?? .systemRed
            cell.changeSubtitleText(text: strokeColor, textColor: textColor)
            
            return cell
        }
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch SettingsType.allCases[indexPath.row] {
        case .switcher:
            print("Switch")
        case .color:
            print("navigate")
            navigationAction()
        }
    }
}

private extension SettingsViewController {
    func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = Constants.navigationTitle
        navigationController?.navigationBar.tintColor = .systemRed
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(DrawStroiesCollectionViewCell.self, forCellReuseIdentifier: DrawStroiesCollectionViewCell.identifier)
        tableView.register(StrokeColorCollectionViewCell.self, forCellReuseIdentifier: StrokeColorCollectionViewCell.identifier)
        
        tableView.rowHeight = Constants.rowHeight
        tableView.backgroundColor = .systemGray6
        tableView.separatorInset = UIEdgeInsets(
            top: .zero,
            left: Constants.separatorLeftInset,
            bottom: .zero,
            right: Constants.separatorRightInset
        )
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func navigationAction() {
        let colorVC = ColorPickerViewController(viewModel: ColorPickerViewModel())
        navigationController?.pushViewController(colorVC, animated: true)
    }
}
