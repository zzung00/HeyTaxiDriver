//
//  UserDTO.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/01/30.
//

import Foundation

struct UserModel: Codable {
    private let name: String
    private let username: String
    
    init(name: String, username: String) {
        self.name = name
        self.username = username
    }
}
