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
            //택시 상태 텍스트로 표시 추가 예정
            if viewModel.userLocationAlert == true {
                //새로운 bottom sheet 생성 후, 기존 메인 화면에 빈차(empty)와 퇴근(off) 표시
                //new sheet에 승객의 src, dst, 승차(reservation)와 하차(off) 표시
            }
            
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
                .background(Color.on)
                .cornerRadius(10)
                .foregroundColor(.white)
                .font(Font.body.bold())
                .frame(width: 220)
                
                Button(action: {viewModel.setStatus(status: TaxiStatus.off)}) {
                    Text("하차")
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
                Alert(title: Text("HeyTaxi"), message: Text("콜 수락하시겠습니까?\n\r \(viewModel.address)"), primaryButton: .destructive(Text("수락"))
                      {viewModel.allowReservation()}
                      , secondaryButton: .cancel(Text("거절"))
                      {viewModel.rejectReservation()}
                )
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

// car status(0: 빈차, 1: 승차, 2: 하차)
// 상단에 택시 상태 문구 표시...
