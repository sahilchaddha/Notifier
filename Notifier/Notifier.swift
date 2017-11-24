//
//  Notifier.swift
//  Notifier
//
//  Created by Sahil Chaddha on 23/11/2017.
//  Copyright © 2017 Sahil Chaddha. All rights reserved.
//

import Foundation
import Dispatch

protocol NotifierType {
    func notify()
}

class Notifier: NotifierType {
    let semaphore: DispatchSemaphore
    
    init() {
        semaphore = DispatchSemaphore(value: 0)
    }
    
    func notify()  {
        let argC = CommandLine.argc
        var message = "Task Completed !"
        
        if argC > 1 {
            message = CommandLine.arguments[1]
        }
    
        sendNotification(message: message)
    }
    
    private func sendNotification(message: String) {
        let parameters: [String: String] = ["text": message]
        let headers: [String: String] = ["Content-Type": "application/json"]
        
        guard let slackHooksURL: URL = URL(string: Environment().slackHooksURL) else {
            fputs("Error: \(NotifierError.InvalidSlackURL)\n", stderr)
            return
        }
        
        var req: URLRequest = URLRequest(url: slackHooksURL)
        req.httpBody = try? JSONEncoder().encode(parameters)
        req.httpMethod = "post"
        req.allHTTPHeaderFields = headers
        let dataTask = URLSession.shared.dataTask(with: req) { (data, res, err) in
            print("Notification Sent !")
            self.semaphore.signal()
        }
        dataTask.resume()
        
        semaphore.wait()
    }
}

extension Notifier {
    enum NotifierError: Error {
        case InvalidSlackURL
    }
}
