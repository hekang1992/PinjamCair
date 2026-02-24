//
//  AppViewModel.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import Foundation

final class AppViewModel {
    
    func loginApi(phone: String, password: String) async throws -> BaseModel {
        
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
