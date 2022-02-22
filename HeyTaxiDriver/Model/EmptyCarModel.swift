//
//  EmptyCarModel.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/02/22.
//

import Foundation

struct EmptyCarModel: Codable {
    let taxi: TaxiModel?
    let location: LocationModel
    
    init(taxi: TaxiModel, location: LocationModel) {
        self.taxi = taxi
        self.location = location
    }
}
