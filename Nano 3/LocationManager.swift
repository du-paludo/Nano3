//
//  LocationManager.swift
//  Nano 3
//
//  Created by Eduardo Stefanel Paludo on 26/09/23.
//

import Foundation
import CoreLocation
import Combine
import SwiftData

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startUpdatingLocation()
    }
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, manager.authorizationStatus)
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:  // Location services are available.
            print("Autorizado")
            manager.startUpdatingLocation()
            break
            
        case .restricted, .denied:  // Location services currently unavailable.
            print("Não autorizado")
            break
            
        case .notDetermined:        // Authorization not determined yet.
            print("Não determinado")
            manager.requestAlwaysAuthorization()
            break
            
        default:
            print("Nenhum")
            break
        }
    }


    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
//      print(#function, location)
    }
    
    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
}
