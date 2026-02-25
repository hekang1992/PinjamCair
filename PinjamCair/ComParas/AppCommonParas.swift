//
//  AppCommonParas.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import DeviceKit
import Foundation

final class AppCommonParas {
    
    static let shared = AppCommonParas()
    
    private init() {}
    
    func toDictionary() -> [String: String] {
        let idfv = IDFVKeychainManager.shared.getIDFV()
        var dict: [String: String] = [:]
        dict["seible"] = "ios"
        dict["sexfier"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
        dict["pedian"] = Device.current.description
        dict["capry"] = idfv
        dict["mensural"] = idfv
        dict["egrischoolular"] = UIDevice.current.systemVersion
        dict["vicesimhang"] = "appstore-uagki"
        dict["maliion"] = LoginManager.shared.getToken()
        dict["sagacain"] = currentLanguageCode()
        return dict
    }
}

private extension AppCommonParas {
    
    func currentLanguageCode() -> String {
        let language = LanguageManager.shared.currentType
        
        switch language {
        case .indonesian:
            return "ANG"
            
        case .english:
            return "ITA"
        }
    }
}

extension String {
    func appendingQueryParameters(parameters: [String: String]) -> String {
        guard var components = URLComponents(string: self) else { return self }
        var queryItems = components.queryItems ?? []
        
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        components.queryItems = queryItems
        return components.url?.absoluteString ?? self
    }
}
