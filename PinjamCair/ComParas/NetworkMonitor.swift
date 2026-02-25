//
//  NetworkMonitor.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/25.
//

import Foundation
import Alamofire

final class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    private let manager = NetworkReachabilityManager()
    
    enum ConnectionType {
        case wifi
        case cellular
        case unavailable
        
        var description: String {
            switch self {
            case .wifi: return "WiFi"
            case .cellular: return "5G"
            case .unavailable: return "NONE"
            }
        }
    }
    
    func startListening() {
        manager?.startListening { [weak self] status in
            guard let self = self else { return }
            
            switch status {
            case .reachable(.cellular):
                self.stopListening()
                NotificationCenter.default.post(name: .networkChanged, object: nil, userInfo: ["type": ConnectionType.cellular])
                
            case .reachable(.ethernetOrWiFi):
                self.stopListening()
                NotificationCenter.default.post(name: .networkChanged, object: nil, userInfo: ["type": ConnectionType.wifi])
                
            case .notReachable:
                NotificationCenter.default.post(name: .networkChanged, object: nil, userInfo: ["type": ConnectionType.unavailable])
                
            default:
                break
            }
        }
    }
    
    func stopListening() {
        manager?.stopListening()
    }
}

extension Notification.Name {
    static let networkChanged = Notification.Name("networkChanged")
}
