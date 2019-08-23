//
//  CSEViewController.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 23/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

// Colored Squares Everywhere Game
class CSEViewController: UIViewController {
    
    let palette = [
        UIColor.blue,
        .red,
        .green,
    ]
    
    var selectedColor: UIColor?
    var myPalette = [UIColor]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPalette.append(palette[Int.random(in: 1...10) % palette.count]!)
    }

    @IBAction func onHelpButtonTap(_ sender: Any) {
        performSegue(withIdentifier: "ShowHelp", sender: self)
    }
}

extension CSEViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPalette.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaletteCollectionViewCellIdentifier", for: indexPath)
        
        cell.layer.backgroundColor = myPalette[indexPath.row].cgColor
        
        return cell
    }
    
    
}
