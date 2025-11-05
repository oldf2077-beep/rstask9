//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 17.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import Foundation

class SettingsManager {
    static let shared = SettingsManager()
    private let userDefaults = UserDefaults.standard
    private let settingsKey = "appSettings"
    
    var currentSettings: AppSettings {
        get {
            if let data = userDefaults.data(forKey: settingsKey),
               let settings = try? JSONDecoder().decode(AppSettings.self, from: data) {
                return settings
            }
            return AppSettings()
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                userDefaults.set(data, forKey: settingsKey)
            }
        }
    }
    
    private init() {}
    
    func updateSettings(_ updateBlock: (inout AppSettings) -> Void) {
        var settings = currentSettings
        updateBlock(&settings)
        currentSettings = settings
    }
    
    func resetToDefaults() {
        currentSettings = AppSettings()
    }
}
