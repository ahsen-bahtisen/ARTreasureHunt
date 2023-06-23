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
                CLLocationCoordinate2D(latitude: 38.718968, longitude: 35.516807),
                CLLocationCoordinate2D(latitude: 38.726200, longitude: 35.518661),
                CLLocationCoordinate2D(latitude: 38.724762, longitude: 35.553793),
                CLLocationCoordinate2D(latitude: 38.728432, longitude: 35.492548)
            ]
        }
}
