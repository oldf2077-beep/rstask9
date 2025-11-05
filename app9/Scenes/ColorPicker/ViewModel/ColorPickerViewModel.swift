//
// 📰 🐸 
// Project: app9
// 
// Author: akote
// On: 31.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import Foundation
import UIKit

class ColorPickerViewModel {
    private enum Constants {
        static let availableColors: [UIColor] = [
            .systemRed, .systemBlue, .systemGreen, .systemYellow, .systemOrange,
            .systemPurple, .systemPink, .systemTeal, .systemIndigo, .systemBrown,
            .systemGray, .magenta
        ]
    }
    
    var colorItems: [ColorItem]
    private let settingsManager = SettingsManager.shared
    private var selectedIndex: Int?
    
    init() {
        colorItems = []
        setupData()
    }
    
    func selectedColorIndex() -> Int {
        let currentColor = settingsManager.currentSettings.strokeColor
        return colorItems.firstIndex(where: { $0.hexCode == currentColor }) ?? 0
    }
    
    func selectColor(at index: Int) -> (previousIndex: Int?, currentIndex: Int) {
        let previousIndex = selectedIndex
        
        if let prevIndex = previousIndex {
            colorItems[prevIndex].isSelected = false
        }
        
        colorItems[index].isSelected = true
        selectedIndex = index
        
        return (previousIndex: previousIndex, currentIndex: index)
    }
}

private extension ColorPickerViewModel {
    func setupData() {
        colorItems = Constants.availableColors.map { ColorItem(color: $0) }

        let initialIndex = selectedColorIndex()
        selectedIndex = initialIndex
        colorItems[initialIndex].isSelected = true
    }
}
