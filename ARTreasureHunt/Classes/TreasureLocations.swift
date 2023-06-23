//
//  TreasureLocations.swift
//  ARTreasureHunt
//
//  Created by Ahsen Bahtışen on 23.06.2023.
//

import Foundation
import CoreLocation


class TreasureLocations {
    var locations: [CLLocationCoordinate2D]

    init() {
        locations = [
            CLLocationCoordinate2D(latitude: 38.7194111800447, longitude: 35.514434174711106),
            CLLocationCoordinate2D(latitude: 41.262690, longitude: 34.981751),
            CLLocationCoordinate2D(latitude: 39.230658, longitude: 36.332275),
            CLLocationCoordinate2D(latitude: 39.792139, longitude: 32.632191),
            CLLocationCoordinate2D(latitude: 40.996720, longitude: 29.224573),
            CLLocationCoordinate2D(latitude: 36.351571, longitude: 32.880717)
        ]
        
        // Rastgele koordinatlara dönüştür
        locations = randomCoordinates(locations)
    }
    
    private func randomCoordinates(_ coordinates: [CLLocationCoordinate2D]) -> [CLLocationCoordinate2D] {
        var randomizedCoordinates = [CLLocationCoordinate2D]()
        
        for coordinate in coordinates {
            // Rastgele küçük bir sapma ekleyerek yeni bir koordinat oluştur
            let latitude = coordinate.latitude + Double.random(in: -0.01...0.01)
            let longitude = coordinate.longitude + Double.random(in: -0.01...0.01)
            
            let randomizedCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            randomizedCoordinates.append(randomizedCoordinate)
        }
        
        return randomizedCoordinates
    }
}


