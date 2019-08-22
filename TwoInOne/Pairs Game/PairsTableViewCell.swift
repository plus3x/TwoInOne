//
//  PairsTableViewCell.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 21/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

class PairsTableViewCell: UITableViewCell {
    
    static let identifier = "PairsTableViewCellIdentifier"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pairs: [Pair] = []
    var selectedPairIndexPath: IndexPath?
    
    func configure(with pairs: [Pair]) {
        self.pairs = pairs
        
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
        
        if let selectedPairIndexPath = selectedPairIndexPath {
            pairs[selectedPairIndexPath.row] = pairs[indexPath.row]
        }
        
        selectedPairIndexPath = indexPath
        
        cell.layer.borderWidth = 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PairCollectionViewCell
        
        selectedPairIndexPath = nil
        
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.mainBackground?.cgColor
    }
}
