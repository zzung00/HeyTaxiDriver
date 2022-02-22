//
//  LocationModel.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/02/22.
//

import Foundation

struct LocationModel: Codable {
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
