//
//  MainView.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/01/29.
//

import SwiftUI
import CoreLocation

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var dst = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 30) {
                Button(action: {viewModel.setStatus(status: TaxiStatus.empty)}) {
                    Text("빈 차")
                        .frame(width: 220, height: 50)
                }
                .background(Color.empty)
                .cornerRadius(10)
                .foregroundColor(.white)
                .font(Font.body.bold())
                .frame(width: 220)
                
                Button(action: {}) {
                    Text("승차")
                        .frame(width: 220, height: 50)
                }
                .background(Color.mainGreen)
                .cornerRadius(10)
                .foregroundColor(.white)
                .font(Font.body.bold())
                .frame(width: 220)
                
                Button(action: {}) {
                    Text("출근")
                        .frame(width: 220, height: 50)
                }
                .background(Color.on)
                .cornerRadius(10)
                .foregroundColor(.white)
                .font(Font.body.bold())
                .frame(width: 220)
                
                Button(action: {viewModel.setStatus(status: TaxiStatus.off)}) {
                    Text("퇴근")
                        .frame(width: 220, height: 50)
                }
                .background(Color.off)
                .cornerRadius(10)
                .foregroundColor(.white)
                .font(Font.body.bold())
                .frame(width: 220)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person")
                            
                    }
                    
                }
            }
            .onAppear {
                viewModel.loadMe()
                viewModel.requestPermission()
                viewModel.registerSocket()
            }
            
            .alert(isPresented: $viewModel.reserveAlert) {
                Alert(title: Text("HeyTaxi"), message: Text("콜 수락하시겠습니까? \(String(describing: viewModel.reservationInfo!.call.dst))"), primaryButton: .destructive(Text("수락")), secondaryButton: .cancel(Text("거절")))
            }
            
        }.navigationBarHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

// 콜 수락은 dialog 띄우고 타이머 5초 유지
// after 승객 하차, 요금 결제 다이얼로그 띄우기

// car status(0: 빈차 및 on, 1: 예약, 2: 퇴근 및 승차)
// 상단에 택시 상태 문구 표시...
