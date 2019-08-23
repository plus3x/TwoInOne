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
    var selectedCellIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pairs = Array(0 ..< amountOfRows).map { i in
            let firstIndex = Int.random(in: 0...palette.count)
            
            return Array(0 ..< amountOfColors).map { n in
                let color = self.palette[(firstIndex + n) % self.palette.count]
                
                return Pair(index: n + 1, color: color)
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
    
        cell.delegate = self
        cell.configure(in: indexPath.section, with: pairs[indexPath.section])
        
        return cell
    }
    
}

extension PairsGameViewController: PairsGameViewControllerDelegate {
    func select(in section: Int, at indexPath: IndexPath) {
        if let selectedCellIndexPath = selectedCellIndexPath {
            self.selectedCellIndexPath = nil
            pairs[selectedCellIndexPath.section][selectedCellIndexPath.row].state = .deselecting
            pairs[section][indexPath.row].state = .normal
            
            let selectedPair = pairs[selectedCellIndexPath.section][selectedCellIndexPath.row]
        
            pairs[selectedCellIndexPath.section][selectedCellIndexPath.row] = pairs[section][indexPath.row]
            pairs[section][indexPath.row] = selectedPair
            
            let firstSection = selectedCellIndexPath.section
            let firstPair = pairs[selectedCellIndexPath.section][selectedCellIndexPath.row]
            let firstPairIndexPath = selectedCellIndexPath
            
            if firstPairIndexPath.row > 0 {
                let leftPair = pairs[firstPairIndexPath.section][firstPairIndexPath.row - 1]
                
                if firstPair.index == leftPair.index || firstPair.color == leftPair.color {
                    leftPair.state = .collapsing
                    firstPair.state = .collapsing
                }
            }
            
            if firstPairIndexPath.row < pairs[firstSection].count - 1 {
                let rightPair = pairs[firstPairIndexPath.section][firstPairIndexPath.row + 1]
                
                if firstPair.index == rightPair.index || firstPair.color == rightPair.color {
                    rightPair.state = .collapsing
                    firstPair.state = .collapsing
                }
            }
            
            let secondSection = section
            let secondPair = pairs[section][indexPath.row]
            let secondPairIndexPath = IndexPath(row: indexPath.row, section: section)
            
            if secondPairIndexPath.row > 0 {
                let leftPair = pairs[secondPairIndexPath.section][secondPairIndexPath.row - 1]
                
                if secondPair.index == leftPair.index || secondPair.color == leftPair.color {
                    leftPair.state = .collapsing
                    secondPair.state = .collapsing
                }
            }
            
            if secondPairIndexPath.row < pairs[secondSection].count - 1 {
                let rightPair = pairs[secondPairIndexPath.section][secondPairIndexPath.row + 1]
                
                if secondPair.index == rightPair.index || secondPair.color == rightPair.color {
                    rightPair.state = .collapsing
                    secondPair.state = .collapsing
                }
            }
            
            // Animation state to UICollectionViewCell collapse
            // tableView.reloadData()
            
            pairs[firstSection].removeAll(where: { $0.state == .collapsing })
            pairs[secondSection].removeAll(where: { $0.state == .collapsing })
            
            tableView.reloadData()
        } else {
            self.selectedCellIndexPath = IndexPath(row: indexPath.row, section: section)
            pairs[section][indexPath.row].state = .selecting
            
            tableView.reloadData()
        }
    }
}
