//
// 📰 🐸 
// Project: app9
// 
// Author: akote
// On: 28.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import Foundation

struct JsonData: Decodable {
    let data: [JsonItem]
}

struct JsonStoryData: Decodable {
    let data: [JsonStory]
}

struct JsonGalleryData: Decodable {
    let data: [JsonGallery]
}
