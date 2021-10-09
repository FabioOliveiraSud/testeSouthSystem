//
//  ImageViewExtension.swift
//  My Events
//
//  Created by Fabio Avila Oliveira on 08/10/2021.
//  Copyright © 2021 Fabio Avila Oliveira. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func getImageFrom(url: String) {
        
        guard let url = URL(string: url) else { return }
        
        let fetchImage = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            guard let data = data else { return }
            
            if let error = error {
                print("Fetch Image Failed \(error.localizedDescription)")
                self.image = UIImage(named: "default_event")
            }
            
            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            
        }
        fetchImage.resume()
    }
    
}
