//
//  TokenUtils.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/02/06.
//

import Foundation
import Security
import Alamofire

class TokenUtils {
    
    //CREATE
    static func create(_ service: String, account: String, value: String) {
        //query
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
        ]
        //allowLossyConversion은 encoding과정에서 손실되는 것 허용 설정
        
        //key값에 중복 발생하면 저장 불가능하기 때문에 먼저 delete
        SecItemDelete(keyChainQuery)
        
        //create
        let status: OSStatus = SecItemAdd(keyChainQuery, nil)
        assert(status == noErr, "토큰 저장 실패!!!")
    }
    
    //READ
    static func read(_ service: String, account: String) -> String? {
        let KeyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: kCFBooleanTrue,
            kSecMatchLimit: kSecMatchLimitOne //중복되는 경우, 하나의 값만 가져오라는 의미
        ]
        //CFData 타입 -> AnyObject로 받고, Data로 타입변환해서 사용
        
        //read
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(KeyChainQuery, &dataTypeRef)
        
        if(status == errSecSuccess) {
            let retrievedData = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        } else {
            print("로딩 실패!!! status code = \(status)")
            return nil
        }
    }
    
    //DELETE
    static func delete(_ service: String, account: String) {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ]
        
        let status = SecItemDelete(keyChainQuery)
        assert(status == noErr, "값 삭제 실패!!!, status code = \(status)")
    }
    
    //HTTPHeaders
    static func getToken(serviceID: String) -> String? {
        let serviceID = serviceID
        
        if let accessToken = self.read(serviceID, account: "accessToken") {
            return "bearer \(accessToken)"
        } else {
            return nil
        }
    }
}
