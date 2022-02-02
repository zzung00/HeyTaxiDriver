//
//  SplashViewModel.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/02/02.
//

import Foundation
import Alamofire

class SplashViewModel: ObservableObject {
    @Published var connects: Bool = false
    
    func serverConnect() {
        HeyTaxiService.shared.serverConnect { result in
            self.connects = result
        }
    }
}
