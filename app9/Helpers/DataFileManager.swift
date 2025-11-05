import Foundation

class DataFileManager {
    enum DataPaths {
        static let dataPath = "Data.json"
        static let storyPath = "StoryData.json"
        static let galleryPath = "GalleryData.json"
    }
    
    static let shared = DataFileManager()
    
    func readContentFromFile(pathInStatic path: String) -> String? {
        guard let folderURL = Bundle.main.url(forResource: path, withExtension: nil) else {
            print("Файл не найден:")
            return nil
        }

        do {
            let content = try String(contentsOf: folderURL, encoding: .utf8)
            return content
        } catch {
            print("Ошибка чтения файла: \(error)")
            return nil
        }
    }
    
    func readFileData(named fileName: String, pathInStatic path: String = "Static") -> Data? {
        guard let fileURL = getFileURL(named: fileName, pathInStatic: path) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            print("Ошибка чтения данных файла \(fileName): \(error)")
            return nil
        }
    }
    
    func getItems() -> [JsonItem]? {
        guard let data = readFileData(named: DataPaths.dataPath) else { return nil}
        
        return BasicJSONParser.parseArrayFromData(data)
    }
    
    func getStory(with id: Int) -> JsonStory? {
        guard let data = readFileData(named: DataPaths.storyPath) else { return nil}

        return BasicJSONParser.parseStoryFromDataById(data, id)
    }
    
    func getGallery(with id: Int) -> JsonGallery? {
        guard let data = readFileData(named: DataPaths.galleryPath) else { return nil}
        
        return BasicJSONParser.parseGalleryFromDataById(data, id)
    }
    
    private func getFileURL(named fileName: String, pathInStatic path: String) -> URL? {
       
        if let dataFolderURL = Bundle.main.url(forResource: path, withExtension: nil) {
            let fileURL = dataFolderURL.appendingPathComponent(fileName)
            if FileManager.default.fileExists(atPath: fileURL.path) {
                return fileURL
            }
        }
        return nil
    }
}
