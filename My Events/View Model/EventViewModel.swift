//
//  EventViewModel.swift
//  My Events
//
//  Created by Fabio Avila Oliveira on 08/10/2021.
//  Copyright © 2021 Fabio Avila Oliveira. All rights reserved.
//

import Foundation

class EventViewModel {
    
    let network = EventNetwork()
    var events: [Event] = []
    
    func fetchEvents(completion: @escaping (Bool?) -> Void) {
        network.fetchEvents { events, error in
            if error == nil {
                self.events = events!
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func postCheckiIn(eventID: String, name: String, email: String, completion: @escaping (Bool,String?) -> Void) {
        network.postCheckIn(eventID: eventID, name: name, email: email) { isCheckedIn, errorMessage in
            if let errorMessage = errorMessage {
                completion(false, errorMessage)
            } else {
                completion(true, nil)
            }
        }
    }
}

//View -> Controller -> ViewModel -> Model
