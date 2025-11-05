//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 17.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import Foundation

struct Item: Decodable {
    let id: Int
    let type: ItemType
    let coverImage: String
    let title: String
}

extension Item{
    enum ItemType: String, Decodable {
        case story = "Story"
        case gallery = "Gallery"
        
        init(from jsonItemType: JsonItem.ItemType) {
            self = ItemType(rawValue: jsonItemType.rawValue) ?? ItemType.story
        }
    }
}

