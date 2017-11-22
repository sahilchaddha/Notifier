//
//  Notifier.swift
//  Notifier
//
//  Created by Sahil Chaddha on 23/11/2017.
//  Copyright © 2017 Sahil Chaddha. All rights reserved.
//

import Foundation
import Dispatch

class Notifier {
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
        
        let parameters: [String: String] = ["text": message]
        let headers: [String: String] = ["Content-Type": "application/json"]
        let slackURL: URL? = URL(string: "") //Your Slack Hook e.g. https://hooks.slack.com/services/abcd
        
        guard let baseURL = slackURL else {
            print("Invalid Slack URL")
            return
        }
        
        var req: URLRequest = URLRequest(url: baseURL)
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
