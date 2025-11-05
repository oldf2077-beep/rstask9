//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 21.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import Foundation

class BasicJSONParser {
    static func parseArrayFromData(_ data: Data) -> [JsonItem]? {
        do {
            let jsonData = try JSONDecoder().decode(JsonData.self, from: data)
           
            return jsonData.data
        } catch {
            print("Ошибка парсинга массива JSON: \(error)")
            return nil
        }
    }
    
    static func parseStoryFromDataById(_ data: Data, _ id: Int) -> JsonStory? {
        do {
            let jsonData = try JSONDecoder().decode(JsonStoryData.self, from: data)
            guard var story = jsonData.data.first(where: { $0.id == id }) else {
                return nil
            }
            story.content = DataFileManager.shared.readContentFromFile(pathInStatic: story.contentPath) ?? ""
            return story
        } catch {
            print("Ошибка парсинга массива JSON: \(error)")
            return nil
        }
    }
    
    static func parseGalleryFromDataById(_ data: Data, _ id: Int) -> JsonGallery? {
        do {
            let jsonData = try JSONDecoder().decode(JsonGalleryData.self, from: data)
            return jsonData.data.first(where: { $0.id == id })
        } catch {
            print("Ошибка парсинга массива JSON: \(error)")
            return nil
        }
    }
}
