//
//  HeyTaxiService.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/01/30.
//

import Alamofire
import Combine
import Foundation

struct VerifyResponse: Codable {
    let success: Bool
    let message: String
}

struct HeyTaxiService {
    private let baseUrl = "http://220.124.113.180"
    static let shared = HeyTaxiService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "Accept" : "application/json"
    ]
    
    func verifyRequest(phone: String) {
        let url: String = baseUrl + "/api/verify/request"
        let body: Parameters = [
            "phone": phone
        ]
    }
}
