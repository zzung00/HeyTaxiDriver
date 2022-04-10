//
//  MainViewModel.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/02/06.
//

import Foundation
import StompClientLib
import CoreLocation

class MainViewModel: NSObject, ObservableObject, CLLocationManagerDelegate, StompClientLibDelegate {
    private let url = NSURL(string: "ws://\(HeyTaxiService.host)/heytaxi-ws/websocket")
    @Published private var socketClient = StompClientLib()
    @Published var user: UserModel?
    @Published var taxi: TaxiModel?
    @Published var authorizationStatus: CLAuthorizationStatus
    private let locationManager: CLLocationManager
    @Published var lastSeenLocation: CLLocation?
    private var status = TaxiStatus.off

    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus

        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    //빈 차인 경우, 위치 변경될때마다 실시간 업데이트
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
        if (status == TaxiStatus.empty) {
            sendLocation()
        }
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func loadMe() {
        HeyTaxiService.shared.loadMe {
            result in
            if(result.success) {
                self.user = result.user
            }
        }
    }
    
    func setStatus(status: TaxiStatus) {
        self.status = status
    }
    
    //socket connection
    func registerSocket() {
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as! URL), delegate: self as! StompClientLibDelegate, connectionHeaders: ["Authorization": TokenUtils.getToken(serviceID: HeyTaxiService.baseUrl)!])
    }
    
    func subscribe() {
        socketClient.subscribe(destination: "/user/topic/error")
        socketClient.subscribe(destination: "/user/topic/reservation") // 사용자 정보가 담김, 드라이버가 수락을 눌러야 매칭 완료
    }
    
    func sendLocation() {
        var location : EmptyCarModel = EmptyCarModel(taxi: nil, location: LocationModel(latitude: Double(lastSeenLocation?.coordinate.latitude ?? 0), longitude: Double(lastSeenLocation?.coordinate.longitude ?? 0)))
        let encoder = try! JSONEncoder().encode(location)
        let result = String(data: encoder, encoding: .utf8)
        
        socketClient.sendMessage(message: result!, toDestination: "/app/empty/update", withHeaders: ["Authorization": TokenUtils.getToken(serviceID: HeyTaxiService.baseUrl)!, "content-type": "application/json"], withReceipt: nil)
    }
    
    func allowReservation() {
        let location : CallModel = CallModel(src: LocationModel(latitude: Double(lastSeenLocation?.coordinate.latitude ?? 0), longitude: Double(lastSeenLocation?.coordinate.longitude ?? 0)), dst: LocationModel(latitude: Double(lastSeenLocation?.coordinate.latitude ?? 0), longitude: Double(lastSeenLocation?.coordinate.longitude ?? 0)))
        let encoder = try! JSONEncoder().encode(location)
        let result = String(data: encoder, encoding: .utf8)
        
        socketClient.sendMessage(message: result!, toDestination: "/app/reservation/allow", withHeaders: ["Authorization" : TokenUtils.getToken(serviceID: HeyTaxiService.baseUrl)!, "content-type": "application/json"], withReceipt: nil)
    }
    
    func rejectReservation() {
        let location : CallModel = CallModel(src: LocationModel(latitude: Double(lastSeenLocation?.coordinate.latitude ?? 0), longitude: Double(lastSeenLocation?.coordinate.longitude ?? 0)), dst: LocationModel(latitude: Double(lastSeenLocation?.coordinate.latitude ?? 0), longitude: Double(lastSeenLocation?.coordinate.longitude ?? 0)))
        let encoder = try! JSONEncoder().encode(location)
        let result = String(data: encoder, encoding: .utf8)
        
        socketClient.sendMessage(message: result!, toDestination: "/app/reservation/reject", withHeaders: ["Authorization": TokenUtils.getToken(serviceID: HeyTaxiService.baseUrl)!, "content-type": "application/json"], withReceipt: nil)
    }
    
    // 사용자의 위치가 담긴 후, 예약 관련 다이얼로그 표시
    // 다이얼로그에 수락 및 거절 버튼 생성 후, 그에 맞는 sendMessage 설정
    
    //unsubscribe
    func disconnect() {
        socketClient.disconnect()
    }
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print(destination)
        print(jsonBody!)
    }
    
    func stompClientJSONBody(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("des :" + destination)
        print("jb : " + jsonBody!)
    }

    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Socket is Disconnected!!!")
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        print("Socket is Connected!!!")
        subscribe()
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("receipt: \(receiptId)")
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error send: \(description)")
        socketClient.disconnect()
        registerSocket()
    }
    
    func serverDidSendPing() {
        print("Server ping")
    }
}
