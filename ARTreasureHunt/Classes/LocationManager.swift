//
//  LocationManager.swift
//  ARTreasureHunt
//
//  Created by Ahsen Bahtışen on 23.06.2023.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
   let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        currentLocation = location
        delegate?.didUpdateLocation(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFailWithError(error)
    }
}
