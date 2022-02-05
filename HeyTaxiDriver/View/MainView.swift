//
//  MainView.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/01/29.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Button(action: {}) {
                Text("대기")
            }
            
            Button(action: {}) {
                Text("승차")
            }
            
            Button(action: {}) {
                Text("하차")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
