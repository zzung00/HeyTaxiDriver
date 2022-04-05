//
//  CallModel.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/04/05.
//

import Foundation

struct CallModel: Codable {
    var src: LocationModel
    var dest: LocationModel
    
    init(src: LocationModel, dest: LocationModel) {
        self.src = src
        self.dest = dest
    }
}
