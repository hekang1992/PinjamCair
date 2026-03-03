//
//  AppLocationManager.swift
//  PinjamCair
//
//  Created by hekang on 2026/3/2.
//

import UIKit
import CoreLocation

class AppLocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    var completion: (([String: String]) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation(completion: @escaping ([String: String]) -> Void) {
        self.completion = completion
        
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
    }
}

extension AppLocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            
        case .denied, .restricted:
//            if LanguageManager.shared.currentType == .indonesian {
//                ShowAlertManager.showAlert()
//            }
            completion?([:])
            
        case .notDetermined:
            break
            
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        manager.stopUpdatingLocation()
        
        let lon = String(format: "%.10f", location.coordinate.longitude)
        let lat = String(format: "%.10f", location.coordinate.latitude)
        LoginManager.shared.saveLocationInfo(lon: lon, lat: lat)
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            
            guard let self = self,
                  let placemark = placemarks?.first,
                  error == nil else { return }
            
            let result: [String: String] = [
                "lepeur": placemark.administrativeArea ?? "",
                "lipwalkite": placemark.isoCountryCode ?? "",
                "thativity": placemark.country ?? "",
                "mesoice": placemark.name ?? "",
                "hitant": "\(location.coordinate.latitude)",
                "cuneaneous": "\(location.coordinate.longitude)",
                "weaponent": placemark.locality ?? "",
                "plaudian": placemark.subLocality ?? placemark.subAdministrativeArea ?? ""
            ]
            
            self.completion?(result)
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        if !LoginManager.shared.isLoggedIn() {
            let loginVc = LoginViewController()
            let navVc = AppNavigationController(rootViewController: loginVc)
            navVc.modalPresentationStyle = .overFullScreen
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootVC = windowScene.windows.first?.rootViewController else {
                return
            }
            rootVC.present(navVc, animated: true)
        }
    }
}

class ShowAlertManager {
    
    private static let lastShownDateKey = "LastAlertShownDate"
    
    static func showAlert() {
        if wasAlertShownToday() {
            return
        }
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else {
            return
        }
        
        let alert = UIAlertController(
            title: "权限未开启",
            message: "请在设置中开启权限",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: LocalStr("Cancel"), style: .cancel))
        
        alert.addAction(UIAlertAction(title: LocalStr("Go to Settings"), style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }))
        
        rootVC.present(alert, animated: true)
        
        saveLastShownDate()
    }
    
    private static func wasAlertShownToday() -> Bool {
        guard let lastShownDate = UserDefaults.standard.object(forKey: lastShownDateKey) as? Date else {
            return false
        }
        
        return Calendar.current.isDateInToday(lastShownDate)
    }
    
    private static func saveLastShownDate() {
        UserDefaults.standard.set(Date(), forKey: lastShownDateKey)
    }
    
}
