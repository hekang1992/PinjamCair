//
//  AppViewModel.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import Foundation

final class AppViewModel {
    
    // MARK: - LAUNCH_INFO
    
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
    
}

extension AppViewModel {
    
    // MARK: - ADDRESS_INFO
    
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
    
}

extension AppViewModel {
    
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

extension AppViewModel {
    
    // MARK: - MINE_INFO
    
    func getMineInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.get("/nemaite/togetheretic", parameters: parameters)
            return response
            
        } catch {
            throw error
        }
    }
    
    func deleteInfo() async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.get("/nemaite/nauo")
            return response
            
        } catch {
            throw error
        }
    }
    
    func logoutInfo() async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.get("/nemaite/urgth")
            return response
            
        } catch {
            throw error
        }
    }
    
}

extension AppViewModel {
    
    // MARK: - MINE_INFO
    
    func getHomeInfo() async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.get("/nemaite/casia")
            return response
            
        } catch {
            throw error
        }
    }
}

extension AppViewModel {
    
    // MARK: - CLICK_INFO
    
    func clickProductInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post("/nemaite/omphalacle", parameters: parameters)
            return response
            
        } catch {
            throw error
        }
    }
    
    func productDetailInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post("/nemaite/ogile", parameters: parameters)
            return response
            
        } catch {
            throw error
        }
    }
}

