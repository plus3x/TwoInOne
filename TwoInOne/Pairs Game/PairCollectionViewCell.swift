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
    
    func configure(with pair: Pair) {
        self.pair = pair
        
        indexLabel.text = "\(pair.index)"
        layer.cornerRadius = 3
        backgroundColor = pair.color
        
        switch pair.state {
        case .normal:
            layer.borderWidth = 0
        case .selecting:
            let borderWidthAnimation: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
            layer.borderWidth = 0
            borderWidthAnimation.fromValue = 0
            borderWidthAnimation.toValue = 3
            borderWidthAnimation.duration = 0.3
            layer.add(borderWidthAnimation, forKey: "Width")
            layer.borderWidth = 3
            pair.state = .selected
        case .selected:
            layer.borderWidth = 3
        case .deselecting:
            layer.borderWidth = 3
            let borderWidthAnimation: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
            borderWidthAnimation.fromValue = 3
            borderWidthAnimation.toValue = 0
            borderWidthAnimation.duration = 0.3
            layer.add(borderWidthAnimation, forKey: "Width")
            layer.borderWidth = 0
            pair.state = .normal
        case .collapsing: break
        }
    }
}
