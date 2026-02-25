//
//  AppViewModel.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import Foundation

final class AppViewModel {
    
    // MARK: - launchInfo
    
    func getAppLaunchInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post(
                "/nemaite/dorsally",
                parameters: parameters
            )
            
            return response
            
        } catch {
            throw error
        }
    }
    
    
    func loginApi(phone: String, password: String) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post(
                "/login",
                parameters: [
                    "phone": phone,
                    "password": password
                ]
            )
            
            return response
            
        } catch {
            throw error
        }
    }
    
    
}
