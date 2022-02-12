//
//  ProfileView.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/02/10.
//

import SwiftUI

struct ProfileView: View {
    private var taxi: TaxiModel?
    private var user: UserModel?
    @State private var carNumber = ""
    @StateObject private var viewModel = ProfileViewModel()
    
    init(taxi: TaxiModel, user: UserModel) {
        self.taxi = taxi
        self.user = user
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 30) {                
                Image("taxi")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 250, height: 250)
                    .background(
                        Circle()
                            .fill(Color.mainGreen)
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 4)
                    )
                    .shadow(radius: 10)
                
                TextField("택시번호", text: $carNumber)
                    .frame(width: 300, height: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                    .disableAutocorrection(true)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {}) {
                        Text("취소")
                            .bold()
                            .foregroundColor(.red)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.registerTaxi(name: taxi!.name, carNumber: carNumber)
                    }) {
                        Text("저장")
                            .bold()
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        var user = UserModel(name: "홍길동", username: "1234")
        var taxi = TaxiModel(id: 1, user: user, name: "아우디", carNumber: "12고 3456")
        ProfileView(taxi: taxi, user: user)
    }
}
