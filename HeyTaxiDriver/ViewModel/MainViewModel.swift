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
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as! URL), delegate: self as! StompClientLibDelegate, connectionHeaders: ["Authorization": TokenUtils.getToken(serviceID: HeyTaxiService.baseUrl)!])
    }
    
    func subscribe() {
        socketClient.subscribe(destination: "/user/\((self.user!.username)!)/topic/error")
        socketClient.subscribe(destination: "/user/\((self.user!.username)!)/topic/reservation")
        socketClient.subscribe(destination: "/topic/empty")
        print("/user/\((self.user!.username)!)/topic/error")
    }
    
    func sendLocation() {
        var location : EmptyCarModel = EmptyCarModel(taxi: nil, location: LocationModel(latitude: Double(lastSeenLocation?.coordinate.latitude ?? 0), longitude: Double(lastSeenLocation?.coordinate.longitude ?? 0)))
        let encoder = try! JSONEncoder().encode(location)
        let result = String(data: encoder, encoding: .utf8)
        
        socketClient.sendMessage(message: result!, toDestination: "/app/empty/update", withHeaders: ["Authorization": TokenUtils.getToken(serviceID: HeyTaxiService.baseUrl)!, "content-type": "application/json"], withReceipt: nil)
    }
    
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
