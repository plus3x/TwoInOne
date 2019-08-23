//
//  PairsTableViewCell.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 21/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

protocol PairsGameViewControllerDelegate: class {
    func select(in section: Int, at indexPath: IndexPath)
}

class PairsTableViewCell: UITableViewCell {
    
    static let identifier = "PairsTableViewCellIdentifier"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var section: Int!
    weak var delegate: PairsGameViewControllerDelegate? = nil
    
    var pairs: [Pair] = []
    
    func configure(in section: Int, with pairs: [Pair]) {
        self.section = section
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
        cell.configure(with: pair)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate!.select(in: section, at: indexPath)
    }
}
