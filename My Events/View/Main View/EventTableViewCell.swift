//
//  EventTableViewCell.swift
//  My Events
//
//  Created by Fabio Avila Oliveira on 08/10/2021.
//  Copyright © 2021 Fabio Avila Oliveira. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var labelEventTitle: UILabel!
    @IBOutlet weak var labelEventDate: UILabel!
    @IBOutlet weak var labelEventPrice: UILabel!
    
    var event: Event? {
        didSet{
            guard let event = event else { return }
            fillCellWith(event: event)
        }
    }
    
    func fillCellWith(event: Event) {
        labelEventTitle.text = event.title
        labelEventDate.text = "\(event.date)"
        labelEventPrice.text = "\(event.price)"
    }

}
