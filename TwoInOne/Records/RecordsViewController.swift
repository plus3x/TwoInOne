//
//  RecordsViewController.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 14/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

class RecordsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberColumnButton: UIButton!
    @IBOutlet weak var attemptsColumnButton: UIButton!
    
    var game: RecordSaver.GameName =  .guessingGame
    var records = [Record]()
    
    enum SortColumn {
        case number, attempts
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateRecords()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        sortBy(.number)
    }
    
    @IBAction func onNumberColumnButtonTap(_ sender: Any) {
        sortBy(.number)
    }
    
    @IBAction func onAttemptsColumnButtonTap(_ sender: Any) {
        sortBy(.attempts)
    }
    
    @IBAction func onSegmentedControlTap(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: game = .guessingGame
        case 1: game = .guessingGameTwo
        default: break;
        }
        
        updateRecords()
        tableView.reloadData()
    }
    
    private func updateRecords() {
        do {
            records = try RecordSaver.get(fromGame: game)
        } catch {
            records = []
        }
    }
    
    private func sortBy(_ sortColumn: SortColumn) {
        switch sortColumn {
        case .number:
            numberColumnButton.setTitle("Number^", for: .normal)
            attemptsColumnButton.setTitle("Attempts", for: .normal)
            records.sort { $0.number < $1.number }
        case .attempts:
            numberColumnButton.setTitle("Number", for: .normal)
            attemptsColumnButton.setTitle("Attempts^", for: .normal)
            records.sort { $0.attempts < $1.attempts }
        }
        
        tableView.reloadData()
    }
}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCellIdentifier", for: indexPath) as! RecordTableViewCell
        
        let record = records[indexPath.row]
        cell.numberLabel.text = "\(record.number)"
        cell.attemptsLabel.text = "\(record.attempts)"
        
        return cell
    }
    
}
