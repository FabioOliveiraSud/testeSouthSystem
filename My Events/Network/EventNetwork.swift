//
//  EventNetwork.swift
//  My Events
//
//  Created by Fabio Avila Oliveira on 08/10/2021.
//  Copyright © 2021 Fabio Avila Oliveira. All rights reserved.
//

import Foundation

class EventNetwork: Network {
    
    
    func fetchEvents(completion: @escaping ([Event]?, Error?) -> Void) {
        
        guard var url = URL(string: baseURL) else {return}
        url.appendPathComponent(eventEndPoint)
        
        print("🔗 URL: \(url)")
        
        let urlSession = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            guard let statusCode = response as? HTTPURLResponse else { return }
            let decoder = JSONDecoder()
            
            if let error = error {
                print("Error Fetching Data: \(error.localizedDescription)")
                completion(nil, error)
            }
            
            if statusCode.statusCode == 200 {
                do {
                    let eventResult = try decoder.decode([Event].self, from: data)
                    completion(eventResult, nil)
                } catch let error {
                    print("Error Decoding Data: \(error.localizedDescription)")
                    completion(nil, error)
                }
            }
            
        }
        urlSession.resume()
        
    }
    
    func postCheckIn(eventID: String, name: String, email: String, completion: @escaping (Bool,String?) -> Void) {
        
        guard var url = URL(string: baseURL) else { return }
        url.appendPathComponent(checkInEndPoint)
        
        print("🔗 URL: \(url)")
        
        let parameters: [String: String] = [
            "eventId": eventID,
            "name": name,
            "email": email
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody

        let checkIn = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Error Checking In: \(error.localizedDescription)")
                completion(false,error.localizedDescription)
            } else {
                print("Data posted successfully")
                completion(true, nil)
            }
            
        }
        
        checkIn.resume()
        
    }
        
}
