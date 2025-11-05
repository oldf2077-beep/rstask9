//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 25.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import Foundation
import UIKit

class GalleryViewModel {
    private let dataFileManager = DataFileManager.shared
    private(set) var gallery: GalleryItem?
    
    init(with id: Int) {
        loadGallery(with: id)
    }
    
    func loadGallery(with id: Int) {
        guard let data = dataFileManager.getGallery(with: id) else { return }
        
        gallery = GalleryItem(
            id: data.id,
            coverImage: data.coverImage,
            title: data.title,
            content: data.content
        )
    }
}

