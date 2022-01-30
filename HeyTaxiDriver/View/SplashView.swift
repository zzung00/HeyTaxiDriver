//
//  SplashView.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/01/29.
//

import SwiftUI

struct SplashView: View {
    @State var isActive:Bool = false
    var body: some View {
        VStack {
            if self.isActive {
                MainView()
            } else {
                Text("HeyTaxi")
                    .bold()
                    .foregroundColor(.mainGreen)
                    .font(Font.custom("JalnanOTF", size: 40))
                
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation{
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
