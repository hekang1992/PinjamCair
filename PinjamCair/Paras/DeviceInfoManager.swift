//
//  DeviceInfoManager.swift
//  PinjamCair
//
//  Created by hekang on 2026/3/3.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import Network
import CoreTelephony
import MachO
import NetworkExtension
import DeviceKit

final class DeviceInfoManager: NSObject {
    
    static let shared = DeviceInfoManager()
    
    override init() {
        super.init()
    }
    
    private func getStorageInfo() -> (total: Int64, free: Int64) {
        do {
            let attrs = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            let total = (attrs[.systemSize] as? NSNumber)?.int64Value ?? 0
            let free = (attrs[.systemFreeSize] as? NSNumber)?.int64Value ?? 0
            return (total, free)
        } catch {
            return (0, 0)
        }
    }
    
    private func getMemoryInfo() -> (total: UInt64, free: UInt64) {
        let total = ProcessInfo.processInfo.physicalMemory
        
        var stats = vm_statistics64()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics64>.size / MemoryLayout<integer_t>.size)
        
        let result = withUnsafeMutablePointer(to: &stats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics64(mach_host_self(),
                                  HOST_VM_INFO64,
                                  $0,
                                  &count)
            }
        }
        
        if result == KERN_SUCCESS {
            let pageSize = UInt64(vm_kernel_page_size)
            let active = UInt64(stats.active_count) * pageSize
            let wired = UInt64(stats.wire_count) * pageSize
            let free = total - (active + wired)
            return (total, free)
        }
        
        return (total, 0)
    }
    
    private func getBatteryInfo() -> (level: Int, charging: Int) {
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        let level = max(0, Int(UIDevice.current.batteryLevel * 100))
        let charging = UIDevice.current.batteryState == .charging ||
        UIDevice.current.batteryState == .full ? 1 : 0
        
        return (level, charging)
    }
    
    private func getDeviceInfo() -> (systemVersion: String,
                                     brand: String,
                                     machine: String,
                                     model: String,
                                     height: CGFloat,
                                     width: CGFloat) {
        
        let screen = UIScreen.main.bounds
        
        return (
            UIDevice.current.systemVersion,
            "iPhone",
            Device.identifier,
            UIDevice.current.model,
            screen.height,
            screen.width
        )
    }
    
    private func getTimeZone() -> String {
        TimeZone.current.abbreviation() ?? ""
    }
    
    private func getLanguage() -> String {
        Locale.current.identifier
    }
    
    private func getNetworkType(completion: @escaping (String) -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                completion("Bad Network")
            } else if path.usesInterfaceType(.wifi) {
                completion("WIFI")
            } else if path.usesInterfaceType(.cellular) {
                completion("5G")
            } else {
                completion("Unknown Network")
            }
            monitor.cancel()
        }
        
        monitor.start(queue: queue)
    }
    
    private func getCarrier() -> String {
        let networkInfo = CTTelephonyNetworkInfo()
        return networkInfo.serviceSubscriberCellularProviders?.values.first?.carrierName ?? "Unknown"
    }
    
    private func getIDFV() -> String {
        UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    private func getLocalIPAddress() -> String {
        var address = ""
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                
                if addrFamily == UInt8(AF_INET),
                   let name = String(validatingUTF8: interface!.ifa_name),
                   name == "en0" {
                    
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface!.ifa_addr,
                                socklen_t(interface!.ifa_addr.pointee.sa_len),
                                &hostname,
                                socklen_t(hostname.count),
                                nil,
                                socklen_t(0),
                                NI_NUMERICHOST)
                    
                    address = String(cString: hostname)
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
    
    private func getWiFiInfo(completion: @escaping ([String: String]?) -> Void) {
        
        guard #available(iOS 14.0, *) else {
            completion(nil)
            return
        }
        
        NEHotspotNetwork.fetchCurrent { hotspotNetwork in
            
            guard let network = hotspotNetwork else {
                completion(nil)
                return
            }
            
            let ssid = network.ssid
            let bssid = network.bssid
            
            completion([
                "SSID": ssid,
                "BSSID": bssid
            ])
        }
    }
    
    func buildFullDeviceJSON(completion: @escaping ([String: Any]) -> Void) {
        
        let group = DispatchGroup()
        
        var wifiInfo: [String: String]?
        var networkType = "Unknown Network"
        let idfa = IDFVKeychainManager.shared.getIDFA()
        
        group.enter()
        getWiFiInfo {
            wifiInfo = $0
            group.leave()
        }
        
        group.enter()
        getNetworkType {
            networkType = $0
            group.leave()
        }
        
        group.notify(queue: .main) {
            
            let storage = self.getStorageInfo()
            let memory = self.getMemoryInfo()
            let battery = self.getBatteryInfo()
            let device = self.getDeviceInfo()
            
            let json: [String: Any] = [
                "bedics": [
                    "sibilcauseess": storage.free,
                    "lesion": storage.total,
                    "teloian": memory.total,
                    "themselvesess": memory.free
                ],
                "fulgsure": [
                    "ungulad": battery.level,
                    "filmivity": battery.charging
                ],
                "patipoorty": [
                    "particularlyair": device.systemVersion,
                    "threeot": device.brand,
                    "almable": device.machine,
                    "narfaction": device.model,
                    "ductry": device.height,
                    "sinistrty": device.width,
                    "thesetion": String(Device.current.diagonal)
                ],
                "amphture": [
                    "lunor": 100,
                    "manyette": "0",
                    "failics": Device.current.isSimulator ? "1" : "0",
                    "locochurchfication": 0,
                ],
                "believeaceous": [
                    "opportunityfaction": self.getTimeZone(),
                    "kidship": DeviceInfoManager.isUsingProxy() ? "1" : "0",
                    "fructfold": DeviceInfoManager.isVPNConnected() ? "1" : "0",
                    "denheading": self.getCarrier(),
                    "healtheous": self.getIDFV(),
                    "claustration": self.getLanguage(),
                    "parietitious": networkType,
                    "polemage": Device.current.isPhone ? "1" : "0",
                    "informationitious": self.getLocalIPAddress(),
                    "cancerarium": wifiInfo?["BSSID"] ?? "",
                    "animal": idfa
                ],
                "sceneaceous": [
                    "fragical": [
                        [
                            "proprily": wifiInfo?["BSSID"] ?? "",
                            "policyair": wifiInfo?["SSID"] ?? "",
                            "cancerarium": wifiInfo?["BSSID"] ?? "",
                            "throwality": wifiInfo?["SSID"] ?? ""
                        ]
                    ]
                ]
            ]
            
            completion(json)
        }
    }
}

extension DeviceInfoManager {
    
    private static func isVPNConnected() -> Bool {
        let cfDict = CFNetworkCopySystemProxySettings()
        let nsDict = cfDict!.takeRetainedValue() as NSDictionary
        let keys = nsDict["__SCOPED__"] as? NSDictionary
        
        for key: String in keys?.allKeys as? [String] ?? [] {
            if key.contains("tap") || key.contains("tun") ||
                key.contains("ppp") || key.contains("ipsec") ||
                key.contains("utun") {
                return true
            }
        }
        return false
    }
    
    private static func isUsingProxy() -> Bool {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any] else {
            return false
        }
        
        if let httpProxy = proxySettings["HTTPProxy"] as? String, !httpProxy.isEmpty {
            return true
        }
        
        if let httpsProxy = proxySettings["HTTPSProxy"] as? String, !httpsProxy.isEmpty {
            return true
        }
        
        if let proxyEnable = proxySettings["HTTPEnable"] as? Int, proxyEnable == 1 {
            return true
        }
        
        return false
    }
    
}
