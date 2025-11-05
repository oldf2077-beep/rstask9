//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 21.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import Foundation
import UIKit

class ItemViewModel {
    private(set) var items: [Item] = []
    private let dataFileManager = DataFileManager.shared
    
    init() {
        loadItems()
    }
}

private extension ItemViewModel {
    func loadItems() {
        guard let data = dataFileManager.getItems() else { return }
        data.forEach { item in
            let item = Item(
                id: item.id,
                type: Item.ItemType(from: item.type),
                coverImage: item.coverImage,
                title: item.title
            )
            items.append(item)
        }
    }
}
