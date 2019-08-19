//
//  MasterViewController.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 15/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    let menuItems = [
        MenuItem(name: "Guessing Game", segue: "ShowGuessingGame", view: nil),
        MenuItem(name: "Guessing Game II", segue: nil, view: GuessingGameTwoViewController.self),
        MenuItem(name: "Pairs Game", segue: "ShowPairsGame", view: nil),
        MenuItem(name: "Records", segue: "ShowRecords", view: nil),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCellIdentifier", for: indexPath) as! MenuTableViewCell

        let menuItem = menuItems[indexPath.row]
        cell.menuItemLabel.text = menuItem.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        
        if let segueIdentifier = menuItem.segue {
            performSegue(withIdentifier: segueIdentifier, sender: self)
        } else if let view = menuItem.view {
            let vc = view.init()
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
