//
//  HeyTaxiService.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/01/30.
//

import Alamofire
import Combine
import Foundation
import SwiftUI

struct VerifyResponse: Codable {
    let success: Bool
    let message: String
}

struct HeyTaxiService {
    private let baseUrl = "http://172.30.1.56"
    static let shared = HeyTaxiService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "Accept" : "application/json"
    ]
    
    func serverConnect(completion: @escaping (Bool) -> Void) {
        AF.request(baseUrl, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            DispatchQueue.main.async {
                completion(response.response?.statusCode == 200)
            }
        }
    }

    func verifyRequest(phone: String, completion: @escaping (VerifyResponse) -> Void) {
        let url: String = baseUrl + "/api/verify/request"
        let body: Parameters = [
            "phone": phone
        ]
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default).responseJSON {
            response in
            switch response.result {
            case.success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let verifyResponse = try decoder.decode(VerifyResponse.self, from: data)
                    completion(verifyResponse)
                } catch {
                    
                }
            default:
                return
            }
        }
    }
}
