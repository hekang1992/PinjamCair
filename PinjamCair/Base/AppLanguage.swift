//
//  AppLanguage.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import Foundation

enum AppLanguage: String {
    case en
    case id
    
    init(serverValue: String) {
        switch serverValue {
        case "1":
            self = .en
        case "2":
            self = .id
        default:
            self = .en
        }
    }
    
    var serverValue: String {
        switch self {
        case .en: return "1"
        case .id: return "2"
        }
    }
}

final class LanguageManager {
    
    private static let languageKey = "AppLanguageKey"
    
    class func setLanguage(from serverValue: String) {
        let language = AppLanguage(serverValue: serverValue)
        UserDefaults.standard.set(language.rawValue, forKey: languageKey)
        UserDefaults.standard.synchronize()
    }
    
    class func currentLanguage() -> AppLanguage {
        if let value = UserDefaults.standard.string(forKey: languageKey),
           let language = AppLanguage(rawValue: value) {
            return language
        }
        return .en
    }
}
