//
//  AppLanguage.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import Foundation

enum LanguageType: String {
    case english    = "832"
    case indonesian = "923"
    
    var languageCode: String {
        switch self {
        case .english:    return "en"
        case .indonesian: return "id"
        }
    }
}

final class LanguageManager {
    
    static let shared = LanguageManager()
    
    private(set) var currentBundle: Bundle = .main
    private(set) var currentType: LanguageType = .english
    
    private init() {}
        
    func configure(with externalID: String?) {
        
        if let id = externalID,
           let type = LanguageType(rawValue: id) {
            currentType = type
        } else {
            currentType = .english
        }
        
        let langCode = currentType.languageCode
        
        if let path = Bundle.main.path(forResource: langCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            currentBundle = bundle
        } else {
            currentBundle = .main
        }
    }
        
    func localizedString(_ key: String) -> String {
        return currentBundle.localizedString(forKey: key,
                                             value: nil,
                                             table: nil)
    }
    
    func localizedString(_ key: String, _ args: CVarArg...) -> String {
        let format = currentBundle.localizedString(forKey: key,
                                                   value: nil,
                                                   table: nil)
        return String(format: format, arguments: args)
    }
}

func LocalStr(_ key: String) -> String {
    return LanguageManager.shared.localizedString(key)
}
