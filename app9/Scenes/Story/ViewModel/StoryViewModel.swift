//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 24.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import Foundation
import UIKit

class StoryViewModel {
    private let dataFileManager = DataFileManager.shared
    private(set) var story: StoryItem?
    
    init(with id: Int) {
        loadStory(with: id)
    }
    
    func loadStory(with id: Int) {
        guard let data = dataFileManager.getStory(with: id) else { return}
        
        var paths: [CGPath] = []
        switch id {
        case 1:
            paths = [CGPath.story1path1, CGPath.story1path2, CGPath.story1path3]
        case 2:
            paths = [CGPath.story2path1, CGPath.story2path2]
        case 3:
            paths = [CGPath.story3path1, CGPath.story3path1]
        case 4:
            paths = [CGPath.story4path1, CGPath.story4path2]
        default:
            paths = []
        }
        
        story = StoryItem(
            id: data.id,
            coverImage: data.coverImage,
            title: data.title,
            content: data.content ?? "",
            path: paths
        )
    }
}
