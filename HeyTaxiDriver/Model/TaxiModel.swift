//
//  DriverDTO.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/01/30.
//

import Foundation

struct TaxiModel: Codable {
    private let name: String
    private let carNumber: String
    private let user: UserModel
    private let id: Int
    
    init(id: Int, user: UserModel, name: String, carNumber: String) {
        self.id = id
        self.user = user
        self.name = name
        self.carNumber = carNumber
    }
}
