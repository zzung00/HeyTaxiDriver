//
//  UserDTO.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/01/30.
//

import Foundation

struct UserModel: Codable {
    let id: Int
    let name: String?
    let username: String?
    
    init(id: Int, name: String, username: String) {
        self.id = id
        self.name = name
        self.username = username
    }
}
