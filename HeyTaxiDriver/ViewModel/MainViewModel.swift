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
    private let url = NSURL(string: "ws://172.30.1.17/heytaxi-ws/websocket")
    @Published private var socketClient = StompClientLib()
    @Published var user: UserModel?
    @Published var taxi: TaxiModel?
    @Published var authorizationStatus: CLAuthorizationStatus
    private let locationManager: CLLocationManager
    @Published var lastSeenLocation: CLLocation?

    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus

        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
        
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
    
    //socket connection
    func registerSocket() {
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as! URL), delegate: self as! StompClientLibDelegate, connectionHeaders: ["Authorization": TokenUtils.getToken(serviceID: "http://172.30.1.17")!])
    }
    
    func subscribe() {
        socketClient.subscribe(destination: "/user/\(self.user?.username)/topic/error")
        socketClient.subscribe(destination: "/user/\(self.user?.username)/topic/reservation")
    }
    
    func sendLocation() {
        
    }
    
    //unsubscribe
    func disconnect() {
        socketClient.disconnect()
    }
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        
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
