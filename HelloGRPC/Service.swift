//
//  Service.swift
//  HelloGRPC
//
//  Created by Koichi Saeki on 2020/03/13.
//  Copyright © 2020 Koichi Saeki. All rights reserved.
//

import UIKit
import SwiftUI
import GRPC
import NIO

class Service {
    
    static let shared = Service()
    
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    private let client: Helloworld_GreeterClient
    
    init() {
        let channel = ClientConnection.insecure(group: group)
            .connect(host: "localhost", port: 9090)
        client = Helloworld_GreeterClient(channel: channel)
    }
    
    deinit {
        try? group.syncShutdownGracefully()
    }
    
    func sayHello(name: String) throws -> String {
        var request = Helloworld_HelloRequest()
        request.name = name
        let call = client.sayHello(request)
        let reply: Helloworld_HelloReply
        do {
            reply = try call.response.wait()
        } catch {
            print("RPC error: \(error)")
            throw error
        }
        return reply.message
    }
}
