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
    
    private let latKey = "user_lat"
    private let lonKey = "user_lon"
    
    func saveLoginInfo(phone: String, token: String) {
        UserDefaults.standard.set(phone, forKey: phoneKey)
        UserDefaults.standard.set(token, forKey: tokenKey)
        UserDefaults.standard.synchronize()
    }
    
    func saveLocationInfo(lon: String, lat: String) {
        UserDefaults.standard.set(lon, forKey: lonKey)
        UserDefaults.standard.set(lat, forKey: latKey)
        UserDefaults.standard.synchronize()
    }
    
    func getLon() -> String {
        return UserDefaults.standard.string(forKey: lonKey) ?? ""
    }
    
    func getLat() -> String {
        return UserDefaults.standard.string(forKey: latKey) ?? ""
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
