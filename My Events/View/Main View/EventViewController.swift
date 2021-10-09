//
//  EventViewController.swift
//  My Events
//
//  Created by Fabio Avila Oliveira on 08/10/2021.
//  Copyright © 2021 Fabio Avila Oliveira. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = EventViewModel()
    let cellIdentifier = "eventCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loadData()
    }
    
    func setUI() {
        self.title = "Event"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func loadData() {
        viewModel.fetchEvents { didFinishLoading in
            if let finishedLoading = didFinishLoading, finishedLoading {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}

extension EventViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        
        let event = viewModel.events[indexPath.row]
        cell.event = event
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else { return }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? EventTableViewCell else { return }
        detailVC.event = cell.event
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
}
