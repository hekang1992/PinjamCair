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
        if manager.authorizationStatus == .authorizedWhenInUse ||
            manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        manager.stopUpdatingLocation()
        
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
        print("error: \(error.localizedDescription)")
    }
}
