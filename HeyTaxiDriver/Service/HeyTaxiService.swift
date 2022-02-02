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
    private let baseUrl = "http://172.30.1.30"
    static let shared = HeyTaxiService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "Accept" : "application/json"
    ]
    
    func serverConnect() -> Bool {
        var result: Bool = false
        print("서버 커넥트 호출!!!!!!")
        let request = AF.request(baseUrl, method: .get, encoding: JSONEncoding.default).response
        return request?.statusCode == 200
    }

    func verifyRequest(phone: String) {
        let url: String = baseUrl + "/api/verify/request"
        let body: Parameters = [
            "phone": phone
        ]
    }
}
