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
                Image(systemName: "car")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.mainGreen)
                    .frame(width: 200, height: 200)
                
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
            .onAppear {
                viewModel.loadTaxi {
                    taxi in
                    carNumber = taxi.carNumber
                    carName = taxi.name
                }
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
