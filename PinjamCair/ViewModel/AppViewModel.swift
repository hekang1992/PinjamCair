//
//  AppViewModel.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import Foundation
import UIKit

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
    
    func getMessageInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.get("/nemaite/medicaluous", parameters: parameters)
            return response
            
        } catch {
            throw error
        }
    }
    
    func uploadImageInfo(parameters: [String: String], data: Data) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.uploadImage("/nemaite/participantry", imageData: data, parameters: parameters)
            return response
            
        } catch {
            throw error
        }
    }
    
    func saveImageInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let pageUrl = LanguageManager.shared.currentType == .indonesian ? "/nemaite/event" : "/nemaite/metatic"
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post(pageUrl, parameters: parameters)
            return response
            
        } catch {
            throw error
        }
    }
}

extension AppViewModel {
    
    func getPersonalInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post("/nemaite/viscosee", parameters: parameters)
            return response
            
        } catch {
            throw error
        }
    }
    
    func savePersonalInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post("/nemaite/mustsion", parameters: parameters)
            return response
            
        } catch {
            throw error
        }
    }
    
}

extension AppViewModel {
    
    func getWorkerInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post("/nemaite/feli", parameters: parameters)
            return response
            
        } catch {
            throw error
        }
    }
    
    func saveWorkerInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post("/nemaite/irian", parameters: parameters)
            return response
            
        } catch {
            throw error
        }
    }
    
}

extension AppViewModel {
    
    func getContactInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post("/nemaite/genlike", parameters: parameters)
            return response
            
        } catch {
            throw error
        }
    }
    
    func saveContactInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post("/nemaite/openarium", parameters: parameters)
            return response
            
        } catch {
            throw error
        }
    }
    
    func uploadContactInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post("/nemaite/autoesque", parameters: parameters)
            return response
            
        } catch {
            throw error
        }
    }
    
}

extension AppViewModel {
    
    func getWalletInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post("/nemaite/dipsiauous", parameters: parameters)
            return response
            
        } catch {
            throw error
        }
    }
    
    func saveWalletInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        do {
            let response: BaseModel = try await NetworkManager.shared.post("/nemaite/emesive", parameters: parameters)
            return response
            
        } catch {
            throw error
        }
    }
    
}
