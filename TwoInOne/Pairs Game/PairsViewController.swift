//
//  PairsGameViewController.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 19/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

class PairsGameViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pairs: [[Pair]] = []
    
    let (amountOfColors, amountOfRows) = (10, 8)
    var palette = [
        UIColor.orange,
        .green,
        .red,
        .blue,
        .tan,
        .paleGoldenrod,
        .darkSalmon,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pairs = Array(0 ..< amountOfRows).map { i in
            return Array(0 ..< amountOfColors).map { n in
                let index: Int = (i + n) % self.palette.count
                
                return Pair(index: index + 1, color: self.palette[index])
            }
        }
        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension PairsGameViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return pairs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "\(section + 1)"
//    }
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        let header = view as! UITableViewHeaderFooterView
//
//        header.backgroundView?.backgroundColor = nil
//        header.textLabel?.font = header.textLabel?.font.withSize(20)
//        header.textLabel?.textColor = .mainText
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PairsTableViewCell.identifier, for: indexPath) as! PairsTableViewCell
        
        cell.section = indexPath.section
        cell.delegate = self
        cell.configure(with: indexPath.section)
        
        return cell
    }
    
}

extension PairsGameViewController: PairsGameViewControllerDelegate {
    func getPairs() -> [[Pair]] {
        return pairs
    }
    
    func changePlace(in section: Int, from fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let glassPair = pairs[section][toIndexPath.row]
        
        print("1")
        
        for i in 0 ..< pairs.count { print(pairs[i].map { $0.index }) }
        
        pairs[section][toIndexPath.row] = pairs[section][fromIndexPath.row]
        pairs[section][fromIndexPath.row] = glassPair
        
        print("2")
        
        for i in 0 ..< pairs.count { print(pairs[i].map { $0.index }) }
        
        pairs = PairCollapser.perform(pairs)
        
        print("3")
        
        for i in 0 ..< pairs.count { print(pairs[i].map { $0.index }) }
        
        tableView.reloadData()
    }
}
