//
//  PairsTableViewCell.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 21/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

protocol PairsGameViewControllerDelegate: class {
    func getPairs() -> [[Pair]]
    func changePlace(in section: Int, from fromIndexPath: IndexPath, to toIndexPath: IndexPath)
}

class PairsTableViewCell: UITableViewCell {
    
    static let identifier = "PairsTableViewCellIdentifier"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var section: Int!
    weak var delegate: PairsGameViewControllerDelegate? = nil
    
    var pairs: [Pair] = []
    var selectedPairIndexPath: IndexPath?
    
    func configure(with section: Int) {
        self.section = section
        
        pairs = (delegate?.getPairs()[section])!
        
        collectionView.reloadData()
    }

}

extension PairsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pairs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PairCollectionViewCell.identifier, for: indexPath) as! PairCollectionViewCell
        
        let pair = pairs[indexPath.row]
        cell.isSelected = selectedPairIndexPath == indexPath
        cell.configure(with: pair)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PairCollectionViewCell
        
        if let selectedPairIndexPath = self.selectedPairIndexPath {
            delegate?.changePlace(in: section, from: selectedPairIndexPath, to: indexPath)
            
            configure(with: selectedPairIndexPath.section)
            
            self.selectedPairIndexPath = nil
        } else {
            selectedPairIndexPath = indexPath
        }
        
        let borderWidthAnimation: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderWidthAnimation.fromValue = 0
        borderWidthAnimation.toValue = 3
        borderWidthAnimation.duration = 0.3
        cell.layer.add(borderWidthAnimation, forKey: "Width")
        cell.layer.borderWidth = 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PairCollectionViewCell else { return }
        
        let borderWidthAnimation: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderWidthAnimation.fromValue = 3
        borderWidthAnimation.toValue = 0
        borderWidthAnimation.duration = 0.3
        cell.layer.add(borderWidthAnimation, forKey: "Width")
        cell.layer.borderWidth = 0
    }
}
