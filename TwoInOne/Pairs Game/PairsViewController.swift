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
        return pairs[section].count > 0 ? 1 : 0
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
            pairs[selectedCellIndexPath.section][selectedCellIndexPath.row].state = .deselecting
            self.selectedCellIndexPath = nil
            
            let selectedPair = pairs[selectedCellIndexPath.section][selectedCellIndexPath.row]
            pairs[selectedCellIndexPath.section][selectedCellIndexPath.row] = pairs[section][indexPath.row]
            pairs[section][indexPath.row] = selectedPair
            
            reloadPair(at: selectedCellIndexPath)
            reloadPair(at: IndexPath(row: indexPath.row, section: section))
            
            collapseIfNeeded(at: selectedCellIndexPath)
            collapseIfNeeded(at: IndexPath(row: indexPath.row, section: section))
            
            if pairs.contains(where: { $0.isEmpty}) {
                let emptyRowIndexPaths = pairs.enumerated()
                    .compactMap { $1.isEmpty ? IndexPath(row: 0, section: $0) : nil }
                
                pairs.removeAll(where: { $0.isEmpty })
                
                let indexSet = NSMutableIndexSet()
                emptyRowIndexPaths.forEach({ indexSet.add($0.section) })
                tableView.performBatchUpdates({
                    tableView.deleteSections(indexSet as IndexSet, with: .automatic)
                }) { _ in
                    // Update indexes of rows
                    self.tableView.reloadData()
                }
                
                if pairs.count == 0 {
                    showCongratulations()
                }
            }
        } else {
            selectedCellIndexPath = IndexPath(row: indexPath.row, section: section)
            pairs[section][indexPath.row].state = .selecting
            reloadPair(at: selectedCellIndexPath!)
        }
    }
    
    private func showCongratulations() {
        performSegue(withIdentifier: "ShowCongratulationsVC", sender: self)
    }
    
    private func reloadPair(at indexPath: IndexPath) {
        let rowIndexPath = IndexPath(row: 0, section: indexPath.section)
        let itemIndexPath = IndexPath(row: indexPath.row, section: 0)
        
        let cell = tableView.cellForRow(at: rowIndexPath) as! PairsTableViewCell
        cell.pairs = pairs[indexPath.section]
        cell.collectionView.reloadItems(at: [itemIndexPath])
    }
    
    private func collapseIfNeeded(at indexPath: IndexPath) {
        guard pairs.count - 1 >= indexPath.section, pairs[indexPath.section].count != 0 else { return }
        
        let pair = pairs[indexPath.section][indexPath.row]
        var leftPairRemoved = false
        
        if indexPath.row > 0 {
            let leftPair = pairs[indexPath.section][indexPath.row - 1]
            collapseIfNeeded(first: pair, second: leftPair)
            if leftPair.state == .collapsing { leftPairRemoved = true }
        }
        
        if indexPath.row < pairs[indexPath.section].count - 1 {
            let rightPair = pairs[indexPath.section][indexPath.row + 1]
            collapseIfNeeded(first: pair, second: rightPair)
        }
        
        if pairs[indexPath.section].contains(where: { $0.state == .collapsing }) {
            let collapsingCellIndexPaths = pairs[indexPath.section].enumerated()
                .compactMap { $1.state == .collapsing ? IndexPath(row: $0, section: 0) : nil }
            
            pairs[indexPath.section].removeAll(where: { $0.state == .collapsing })
            
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: indexPath.section)) as! PairsTableViewCell
            cell.pairs = pairs[indexPath.section]
            cell.deletePairs(at: collapsingCellIndexPaths) {
                var newIndexPath = indexPath
                newIndexPath.row -= 1

                if leftPairRemoved { newIndexPath.row -= 1}
                if newIndexPath.row < 0 { newIndexPath.row = 0 }

                self.collapseIfNeeded(at: newIndexPath)
            }
        }
    }
    
    private func collapseIfNeeded(first: Pair, second: Pair) {
        if first.index == second.index || first.color == second.color {
            first.state = .collapsing
            second.state = .collapsing
        }
    }
}
