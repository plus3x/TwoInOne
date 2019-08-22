//
//  PairCollectionViewCell.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 20/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

class PairCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PairCollectionViewCellIdentifier"
    
    @IBOutlet weak var indexLabel: UILabel!
    
    var pair: Pair?
    
    override func awakeFromNib() {
        backgroundColor = pair?.color
    }
    
    func configure(with pair: Pair) {
        self.pair = pair
        
        indexLabel.text = "\(pair.index)"
        backgroundColor = pair.color
    }
    
}
