//
//  Event.swift
//  My Events
//
//  Created by Fabio Avila Oliveira on 06/10/2021.
//  Copyright © 2021 Fabio Avila Oliveira. All rights reserved.
//

import Foundation

struct Event: Codable {
    
    let id: String
    let title: String
    let price: Double
    let latitude: Double
    let longitude: Double
    let image: String
    let description: String
    let date: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title,
        image, description
        case latitude, longitude, date, price
    }

}
