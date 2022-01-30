//
//  LoginVIew.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/01/30.
//

import SwiftUI

struct LoginVIew: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("전화번호를 입력해주세요")
                .bold()
                .foregroundColor(.mainGreen)
                .font(Font.custom("JalnanOTF", size: 30))
            Spacer()
        }.padding(EdgeInsets(top: 70, leading: 0, bottom: 0, trailing: 0))
    }
}

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginVIew()
            
    }
}
