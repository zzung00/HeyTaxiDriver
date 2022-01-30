//
//  UserDTO.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/01/30.
//

import Foundation

struct UserDTO {
    private let name: String
    private let username: String
    
    init(name: String, username: String) {
        self.name = name
        self.username = username
    }
}
