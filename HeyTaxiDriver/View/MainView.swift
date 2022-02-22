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
    
    var coordinate: CLLocationCoordinate2D? {
        viewModel.lastSeenLocation?.coordinate
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 30) {
                Button(action: {}) {
                    Text("빈 차")
                        .frame(width: 220, height: 50)
                }
                .background(Color.empty)
                .cornerRadius(10)
                .foregroundColor(.white)
                .font(Font.body.bold())
                .frame(width: 220)
                
                Button(action: {viewModel.sendLocation()}) {
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
                
                Button(action: {}) {
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
        }.navigationBarHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

// 콜 수락은 dialog 띄우고 타이머 5초 유지
// after 콜 수락, 예약 표시(사용자 위치) 하단에 띄우기
// after 승객 하차, 요금 결제 다이얼로그 띄우기
// 출퇴근 버튼 동작으로 서버에 위치 보내기 및 멈추기
// 승객 승차 중, 콜 요청 불가능
// 위치 관련: ws://172.30.1.17/app/empty/update 에 위도,경도 값만 보내기

