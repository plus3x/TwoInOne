//
//  MasterViewController.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 15/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let menuItems = [
        MenuItem(name: "Welcome", segue: "ShowWelcome"),
        MenuItem(name: "Guessing Game", segue: "ShowDetailGuessingGame"),
        MenuItem(name: "Guessing Game II", segue: "ShowDetailGuessingGameTwo"),
        MenuItem(name: "Pairs Game", segue: "ShowDetailPairsGame"),
        MenuItem(name: "Colored Squares Everywhere Game", segue: "ShowCSEGame"),
        MenuItem(name: "Records", segue: "ShowDetailRecords"),
    ]
    
    var selectedCellIndexPath = IndexPath(row: 4, section: 0)
    var firstTime = true
    
    override func viewDidAppear(_ animated: Bool) {
        if firstTime {
            tableView.reloadData()
            firstTime = false
        }
        
        super.viewDidAppear(animated)
    }
}

extension MasterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as! MenuTableViewCell
        
        let menuItem = menuItems[indexPath.row]
        cell.isSelected = selectedCellIndexPath == indexPath
        cell.configure(with: menuItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        
        performSegue(withIdentifier: menuItem.segue, sender: self)
        
        selectedCellIndexPath = indexPath
        tableView.reloadData()
    }
    
}
