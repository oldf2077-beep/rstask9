//
// 📰 🐸 
// Project: app9
// 
// Author: akote
// On: 27.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import Foundation

struct JsonStory: Decodable {
    let id: Int
    let title: String
    let coverImage: String
    let contentPath: String
    var content: String?
}
