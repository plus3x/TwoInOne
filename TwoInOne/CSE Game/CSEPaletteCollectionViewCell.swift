//
//  CSEPaletteCollectionViewCell.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 26/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

class CSEPaletteCollectionViewCell: UICollectionViewCell {
    var color: UIColor!
    
    func confugure(with color: UIColor) {
        self.color = color
        
        backgroundColor = color
    }
}
