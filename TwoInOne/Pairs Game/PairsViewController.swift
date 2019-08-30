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
        UIColor.orangeCustom,
        .greenCustom,
        .redCustom,
        .blueCustom,
        .tan,
        .paleGoldenrod,
        .darkSalmon,
        .yellowCustom,
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
            
            collapseInNeeded(at: selectedCellIndexPath)
            collapseInNeeded(at: IndexPath(row: indexPath.row, section: section))
            
            pairs.removeAll(where: { $0.isEmpty })
            
            // Animation UITableViewCell collapsing
            
            tableView.reloadData()
        } else {
            self.selectedCellIndexPath = IndexPath(row: indexPath.row, section: section)
            pairs[section][indexPath.row].state = .selecting
            
            tableView.reloadData()
        }
    }
    
    private func collapseInNeeded(at indexPath: IndexPath) {
        let pair = pairs[indexPath.section][indexPath.row]
        
        if indexPath.row > 0 {
            let leftPair = pairs[indexPath.section][indexPath.row - 1]
            collapseIfNeeded(first: pair, second: leftPair)
        }
        
        if indexPath.row < pairs[indexPath.section].count - 1 {
            let rightPair = pairs[indexPath.section][indexPath.row + 1]
            collapseIfNeeded(first: pair, second: rightPair)
        }
        
        // Animation state to UICollectionViewCell collapse
        // tableView.reloadData()
        
        let doCollapseAgain = pairs[indexPath.section].first(where: { $0.state == .collapsing }) != nil
        
        pairs[indexPath.section].removeAll(where: { $0.state == .collapsing })
        
        if doCollapseAgain {
            var newIndexPath = indexPath
            
            if pairs[indexPath.section].count - 1 < newIndexPath.row {
                newIndexPath.row = pairs[indexPath.section].count - 1
            } else if pairs[indexPath.section].count - 1 >= newIndexPath.row  {
                newIndexPath.row -= 1
            }
            
            collapseInNeeded(at: newIndexPath)
        }
    }
    
    private func collapseIfNeeded(first: Pair, second: Pair) {
        if first.index == second.index || first.color == second.color {
            first.state = .collapsing
            second.state = .collapsing
        }
    }
}
