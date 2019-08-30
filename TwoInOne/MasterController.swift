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
        MenuItem(name: "Welcome", segue: "ShowWelcome", selected: false),
        MenuItem(name: "Guessing Game", segue: "ShowDetailGuessingGame", selected: false),
        MenuItem(name: "Guessing Game II", segue: "ShowDetailGuessingGameTwo", selected: false),
        MenuItem(name: "Pairs Game", segue: "ShowDetailPairsGame", selected: false),
        MenuItem(name: "Colored Squares Everywhere Game", segue: "ShowCSEGame", selected: true),
        MenuItem(name: "Records", segue: "ShowDetailRecords", selected: false),
    ]
    
    var selectedCellIndexPath = IndexPath(row: 4, section: 0)
//    var firstTime = true
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        if firstTime {
//            tableView.reloadData()
//            firstTime = false
//        }
//        tableView.reloadRows(at: [selectedCellIndexPath], with: .automatic)
//    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        tableView.reloadRows(at: [selectedCellIndexPath], with: .automatic)
//    }
}

extension MasterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as! MenuTableViewCell
        
        var menuItem = menuItems[indexPath.row]
        menuItem.selected = selectedCellIndexPath == indexPath
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
