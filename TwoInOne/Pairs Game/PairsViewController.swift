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
        
        var index = 0
        pairs = Array(0 ..< amountOfRows).map { i in
            return Array(0 ..< amountOfColors).map { n in
                index += 1
                return Pair(index: index, color: self.palette[(i + n) % self.palette.count])
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        
        header.backgroundView?.backgroundColor = nil
        header.textLabel?.font = header.textLabel?.font.withSize(20)
        header.textLabel?.textColor = .mainText
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PairsTableViewCell.identifier, for: indexPath) as! PairsTableViewCell
        
        let pairs = self.pairs[indexPath.section]
        cell.configure(with: pairs)
        
        return cell
    }
    
    
}
