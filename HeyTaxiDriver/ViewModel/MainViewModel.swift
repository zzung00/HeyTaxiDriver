//
//  MainViewModel.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/02/06.
//

import Foundation
import StompClientLib

class MainViewModel: ObservableObject {
    private let url = NSURL(string: "ws://172.30.1.56/heytaxi-ws/websocket")
    @Published private var socketClient = StompClientLib()
    @Published private var user: UserModel?
    
    func loadMe() {
        HeyTaxiService.shared.loadMe {
            result in
            if(result.success) {
                self.user = result.user
            }
        }
    }
    
    //connect
    func registerSocket() {
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as! URL), delegate: self as! StompClientLibDelegate, connectionHeaders: ["Authorization": ""])
    }
    
    func subscribe(username: String) {
        socketClient.subscribe(destination: "/user/\(username)/topic/error")
        socketClient.subscribe(destination: "/user/\(username)/topic/reservation")
    }
    
    //unsubscribe
    func disconnect() {
        socketClient.disconnect()
    }
    
    //delegate
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Socket is Disconnected!!!")
    }
    
    func stompClientDidConnect(client: StompClientLib!, username: String) {
        print("Socket is Connected!!!")
        subscribe(username: username)
    }
    
    func serverDidSendReceipt(client: StompClientLib!) {
        print("server did send receipt!!!")
    }
    
    func serverDidSendError(client: StompClientLib!) {
        print("server did send error!!!")
        socketClient.disconnect()
        registerSocket()
    }
}
