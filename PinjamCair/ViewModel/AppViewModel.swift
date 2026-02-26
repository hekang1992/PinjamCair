//
//  AppViewModel.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import Foundation

final class AppViewModel {
    
    // MARK: - LAUNCH_INFO☝️
    
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
    
    // MARK: - ADDRESS_INFO🗺️
    
    func getAddressInfo() async throws -> BaseModel {
        do {
            let response: BaseModel = try await NetworkManager.shared.get("/nemaite/sexability")
            return response
            
        } catch {
            throw error
        }
    }
    
    // MARK: - GOOGLE_INFO
    
    func uploadGoogleInfo(parameters: [String: String]) async throws -> BaseModel {
        do {
            let response: BaseModel = try await NetworkManager.shared.post(
                "/nemaite/phrenious",
                parameters: parameters
            )
            
            return response
            
        } catch {
            throw error
        }
    }
    
    // MARK: - LOGIN_INFO
    
    func getCodeInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post(
                "/nemaite/exoality",
                parameters: parameters
            )
            
            return response
            
        } catch {
            throw error
        }
    }
    
    func toLoginInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post(
                "/nemaite/ectopurposeess",
                parameters: parameters
            )
            
            return response
            
        } catch {
            throw error
        }
    }
}
