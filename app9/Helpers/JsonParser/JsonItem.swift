//
// 📰 🐸 
// Project: app9
// 
// Author: akote
// On: 27.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import Foundation

struct JsonItem: Decodable {
    let id: Int
    let type: ItemType
    let title: String
    let coverImage: String
}

extension JsonItem {
    enum ItemType: String, Decodable {
        case story = "Story"
        case gallery = "Gallery"
    }
}
