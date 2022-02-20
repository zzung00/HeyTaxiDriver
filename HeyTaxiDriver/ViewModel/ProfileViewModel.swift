//
//  ProfileViewModel.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/02/12.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var success: Bool = false
    @Published var message: String = ""
    @Published var taxi: TaxiModel?
    
    func registerTaxi(name: String, carNumber: String) {
        HeyTaxiService.shared.registerTaxi(name: name, carNumber: carNumber) {
            result in
            self.success = result.success
            self.message = result.message
            self.taxi = result.taxi
        }
    }
    
    func loadTaxi(completion: @escaping (TaxiModel) -> Void) {
        HeyTaxiService.shared.loadTaxi {
            result in
            if(result.success) {
                self.taxi = result.taxi
                completion(result.taxi)
            }
        }
    }
}
