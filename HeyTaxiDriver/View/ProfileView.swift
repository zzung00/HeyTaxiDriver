//
//  ProfileView.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/02/10.
//

import SwiftUI

struct ProfileView: View {
    @State private var carName = ""
    @State private var carNumber = ""
    @StateObject private var viewModel = ProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 10) {
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
                
                Spacer()
                
                TextField("택시번호", text: $carNumber)
                    .frame(width: 300, height: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                    .disableAutocorrection(true)
                
                TextField("택시이름", text: $carName)
                    .frame(width: 300, height: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                    .disableAutocorrection(true)
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                        Text("취소")
                            .bold()
                            .foregroundColor(.red)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.registerTaxi(name: carName, carNumber: carNumber)
                    }) {
                        Text("저장")
                            .bold()
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
