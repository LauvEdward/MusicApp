//
//  UserPreferences.swift
//  MusicApp
//
//  Created by Lauv Edward on 25/07/2021.
//

import UIKit
enum AppLanguage: String {
    case english = "en"
    case vietnamese = "vi"
    
    var text: String {
        switch self {
        case .english:
            return "English"
        case .vietnamese:
            return "Vietnamese"
        }
    }
}

class UserPreferences {
    // MARK: - Singleton
    static let shared = UserPreferences()
    let userDefaultDataStore = UserDefaultsDataStore()
    
    var appLanguage: AppLanguage = .english
    // MARK: - Properties
    struct UserPreferencesKeys {
        
        static var APP_LANGUAGE_KEY: String {
            return APP_LANGUAGE
        }
    }
    func initialize() {
        loadAppLanguage()
    }
    func saveAppLanguage() {
        // Save app language to UserDefault
        DispatchQueue.global(qos: .background).async(flags: .barrier) { [unowned self] in
            // Save setting data to specific user
            self.userDefaultDataStore.save(forKey: UserPreferencesKeys.APP_LANGUAGE_KEY, value: self.appLanguage.rawValue)
        }
    }
    
    func loadAppLanguage() {
        // Load app language from UserDefault
        if let langValue = self.userDefaultDataStore.fetch(type: String.self, forKey: UserPreferencesKeys.APP_LANGUAGE_KEY) {
            self.appLanguage = AppLanguage(rawValue: langValue) ?? .english
        } else {
            if let deviceLang = NSLocale.current.languageCode {
                self.appLanguage = AppLanguage(rawValue: deviceLang) ?? .english
            } else {
                self.appLanguage = .english
            }
        }
    }
    
    func isSetAppLanguage() -> Bool {
        if self.userDefaultDataStore.fetch(type: String.self, forKey: UserPreferencesKeys.APP_LANGUAGE_KEY) != nil {
            return true
        } else {
            return false
        }
    }
}
