//
//  SplashView.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/01/29.
//

import SwiftUI

struct SplashView: View {
    @State var isActive:Bool = false
    @StateObject private var viewModel = SplashViewModel()
    
    var body: some View {
        VStack {
            if viewModel.connects {
                VerifyView()
            } else {
                Text("HeyTaxi")
                    .bold()
                    .foregroundColor(.mainGreen)
                    .font(Font.custom("JalnanOTF", size: 50))
                
            }
        }
        .onAppear(perform: {
            viewModel.serverConnect()
        })
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
