//
//  LoginVIew.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/01/30.
//

import SwiftUI
import Alamofire

struct LoginVIew: View {
    @State private var tipAmount = ""
    @State private var password = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Text("전화번호를 입력해주세요")
                .bold()
                .foregroundColor(.mainGreen)
                .font(Font.custom("JalnanOTF", size: 30))
            Spacer()
            
            TextField("전화번호", text: $tipAmount)
                .padding(.all)
                .frame(width: 350, height: 60)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.namePhonePad)
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
        }
        .padding(EdgeInsets(top: 70, leading: 0, bottom: 0, trailing: 0))
    }
}

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginVIew()
            
    }
}
