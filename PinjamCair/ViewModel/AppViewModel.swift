//
//  AppViewModel.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import Foundation

final class AppViewModel {
    
    // MARK: - launchInfo☝️
    
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
    
    // MARK: - addressInfo🗺️
    
    func getAddressInfo() async throws -> BaseModel {
        
        do {
            let response: BaseModel = try await NetworkManager.shared.get("/nemaite/sexability")
            return response
            
        } catch {
            throw error
        }
    }
    
    
}
