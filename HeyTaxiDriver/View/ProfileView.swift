//
//  ProfileView.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/02/10.
//

import SwiftUI

struct ProfileView: View {
    @State private var carNumber = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 30) {
                //택시 등록 area
//                Circle()
//                    .fill(Color.mainGreen)
//                    .frame(width: 150, height: 100)
                
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
                    Button(action: {}) {
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
        ProfileView()
    }
}
