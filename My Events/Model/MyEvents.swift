//
//  MyEvents.swift
//  My Events
//
//  Created by Fabio Avila Oliveira on 06/10/2021.
//  Copyright © 2021 Fabio Avila Oliveira. All rights reserved.
//

import Foundation

struct Description: Codable {
    let people: [String]
    let date: Int
    let description: String
}

struct Events: Codable {
    let eventId: Int
    let name: String
    let email: String
}


