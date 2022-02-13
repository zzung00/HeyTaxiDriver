//
//  MainViewModel.swift
//  HeyTaxiDriver
//
//  Created by 이정현 on 2022/02/06.
//

import Foundation
import StompClientLib

class MainViewModel: ObservableObject, StompClientLibDelegate {
    private let url = NSURL(string: "ws://172.30.1.49/heytaxi-ws/websocket")
    @Published private var socketClient = StompClientLib()
    @Published var user: UserModel?
    @Published var taxi: TaxiModel?
    
    func loadMe() {
        HeyTaxiService.shared.loadMe {
            result in
            if(result.success) {
                self.user = result.user
            }
        }
    }
    
    func loadTaxi() {
        HeyTaxiService.shared.loadTaxi {
            result in
            if(result.success) {
                self.taxi = result.taxi
            }
        }
    }
    
    //socket connection
    func registerSocket() {
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as! URL), delegate: self as! StompClientLibDelegate, connectionHeaders: ["Authorization": TokenUtils.getToken(serviceID: "http://172.30.1.49")!])
    }
    
    func subscribe() {
        socketClient.subscribe(destination: "/user/\(self.user?.username)/topic/error")
        socketClient.subscribe(destination: "/user/\(self.user?.username)/topic/reservation")
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
