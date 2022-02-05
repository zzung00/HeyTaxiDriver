//
//  MainView.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/01/29.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Button(action: {}) {
                Text("콜 수락")
                    .frame(width: 220, height: 50)
            }
            .background(Color.mainGreen)
            .cornerRadius(10)
            .foregroundColor(.white)
            .font(Font.body.bold())
            .frame(width: 220)
            
            //Spacer()
            
            Button(action: {}) {
                Text("빈차")
                    .frame(width: 220, height: 50)
            }
            .background(Color.allowCalling)
            .cornerRadius(10)
            .foregroundColor(.white)
            .font(Font.body.bold())
            .frame(width: 220)
            
            //Spacer()
            
            Button(action: {}) {
                Text("예약")
                    .frame(width: 220, height: 50)
            }
            .background(Color.reserveCalling)
            .cornerRadius(10)
            .foregroundColor(.white)
            .font(Font.body.bold())
            .frame(width: 220)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
