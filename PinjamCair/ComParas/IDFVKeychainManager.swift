//
//  IDFVKeychainManager.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import Foundation
import Security
import UIKit

final class IDFVKeychainManager {
    
    static let shared = IDFVKeychainManager()
    
    private let service = Bundle.main.bundleIdentifier ?? "com.default.idfv"
    private let account = "com.app.idfv.key"
    
    private init() {}
    
    func getIDFV() -> String {
        if let saved = readFromKeychain() {
            return saved
        }
        
        let idfv = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        
        saveToKeychain(idfv)
        
        return idfv
    }
}

private extension IDFVKeychainManager {
    
    func saveToKeychain(_ value: String) {
        let data = value.data(using: .utf8)!
        
        let deleteQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(deleteQuery as CFDictionary)
        
        let addQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        
        SecItemAdd(addQuery as CFDictionary, nil)
    }
    
    func readFromKeychain() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess,
           let data = dataTypeRef as? Data,
           let value = String(data: data, encoding: .utf8) {
            return value
        }
        
        return nil
    }
}
