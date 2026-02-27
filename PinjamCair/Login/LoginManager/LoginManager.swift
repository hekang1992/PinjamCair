//
//  LoginManager.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import Foundation

class LoginManager {
    
    static let shared = LoginManager()
    private init() {}
    
    private let phoneKey = "user_phone"
    private let tokenKey = "user_token"
    
    func saveLoginInfo(phone: String, token: String) {
        UserDefaults.standard.set(phone, forKey: phoneKey)
        UserDefaults.standard.set(token, forKey: tokenKey)
        UserDefaults.standard.synchronize()
    }
    
    func getPhone() -> String {
        return UserDefaults.standard.string(forKey: phoneKey) ?? ""
    }
    
    func getToken() -> String {
        return UserDefaults.standard.string(forKey: tokenKey) ?? ""
    }
    
    func deleteLoginInfo() {
//        UserDefaults.standard.removeObject(forKey: phoneKey)
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return !getToken().isEmpty
    }
    
}
