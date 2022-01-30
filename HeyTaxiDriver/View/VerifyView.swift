//
//  VerifyView.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/01/30.
//

import SwiftUI

struct VerifyView: View {
    @State private var tipAmount = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Text("전화번호를 입력해주세요")
                .bold()
                .foregroundColor(.mainGreen)
                .font(Font.custom("JalnanOTF", size: 30))
                .frame(width: 380, height: 50)
            
            TextField("전화번호", text: $tipAmount)
                .frame(width: 350, height: 100)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
            
            Button(action: {}) {
                Text("인증 요청")
                    .frame(width: 220, height: 50)
            }
            .background(Color.mainGreen)
            .cornerRadius(10)
            .foregroundColor(.white)
            .font(Font.body.bold())
            .frame(width: 220)
            
            Spacer()
        }
        .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
    }
}

struct VerifyView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyView()
            
    }
}
