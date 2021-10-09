//
//  DetailViewController.swift
//  My Events
//
//  Created by Fabio Avila Oliveira on 08/10/2021.
//  Copyright © 2021 Fabio Avila Oliveira. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var labelEventTitle: UILabel!
    @IBOutlet weak var labelEventDate: UILabel!
    @IBOutlet weak var labelEventPrice: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    
    //MARK: - Properties
    var event: Event?
    var name: String = ""
    var email: String = ""
    var viewModel = EventViewModel()
    
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @IBAction func checkInButtonTapped(_ sender: UIButton) {
       checkIn()
    }

    //MARK: Methods
    func setUI() {
        if let event = event {
            eventImage.getImageFrom(url: event.image)
            labelEventPrice.text = "Preço: R$\(event.price)"
            labelEventDate.text = "Data: \(event.date)"
            labelEventTitle.text = event.title
            textViewDescription.text = event.description
            self.title = event.title
        }
    }
    
    func checkIn() {
        let alert = UIAlertController(title: "Check In", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Name"
            if let text = textField.text {
                self.name = text
            }
        }
        
        alert.addTextField { textField in
            textField.placeholder = "E-mail"
            if let text = textField.text {
                self.email = text
            }
        }
        
        let checkInButtonAction = UIAlertAction(title: "Check In", style: .default) { _ in
            if let event = self.event {
                self.viewModel.postCheckiIn(eventID: event.id, name: self.name, email: self.email) { isCheckedIn, errorMessage in
                    DispatchQueue.main.async {
                        if let errorMessage = errorMessage, !isCheckedIn {
                            self.notifyResult(title: "Error", message: errorMessage)
                            
                        } else {
                            
                            self.notifyResult(title: "Success", message: "Check in completed successfully.")
                        }
                    }
                    
                }
            }
        }
        
        alert.addAction(checkInButtonAction)
        self.present(alert, animated: true)
        
    }
    
    func notifyResult(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissButtonAction = UIAlertAction(title: "Dismiss", style: .default)
        alert.addAction(dismissButtonAction)
        self.present(alert, animated: true)
    }

}
