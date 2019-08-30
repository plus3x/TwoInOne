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

    @IBOutlet weak var firstColorView: UIView!
    @IBOutlet weak var secondColorView: UIView!
    @IBOutlet weak var thirdColorView: UIView!
    @IBOutlet var firstColorViewGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var secondColorViewGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var thirdColorViewGestureRecognizer: UITapGestureRecognizer!
    
    let palette = [
        UIColor.blueCustom,
        .redCustom,
        .greenCustom,
        .yellowCustom,
        .darkSalmon,
    ]
    
    var level = 1
    var myPalette = [UIColor]()
    weak var previousLevelVC: CSEViewController? = nil
    var nextLevelVC: CSEViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shuffledPalette = palette.shuffled().map { $0 }
        firstColorView.backgroundColor = shuffledPalette[0]
        secondColorView.backgroundColor = shuffledPalette[1]
        thirdColorView.backgroundColor = shuffledPalette[2]
        
        if let previousLevelVC = previousLevelVC {
            level = previousLevelVC.level + 1
            myPalette = previousLevelVC.myPalette
            
            title = levelTitle(level)
        } else {
            let color = shuffledPalette.last!!
            myPalette.append(color)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let nextLevelVC = nextLevelVC {
            navigationItem.rightBarButtonItem?.title = "\(levelTitle(nextLevelVC.level)) ❯"
            navigationItem.rightBarButtonItem?.action = #selector(onForwardButtonTap(_:))
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)], for: .normal)
            
            firstColorViewGestureRecognizer.isEnabled = false
            secondColorViewGestureRecognizer.isEnabled = false
            thirdColorViewGestureRecognizer.isEnabled = false
        }
    }

    @IBAction func onHelpButtonTap(_ sender: Any) {
        performSegue(withIdentifier: "ShowHelp", sender: self)
    }
    
    @IBAction func onColorViewTap(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, animations: {
            self.firstColorView.isHidden = sender.view != self.firstColorView
            self.secondColorView.isHidden = sender.view != self.secondColorView
            self.thirdColorView.isHidden = sender.view != self.thirdColorView
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.chooseColor(color: sender.view?.backgroundColor)
        })
    }
    
    @objc private func onForwardButtonTap(_ sender: Any?) {
        if let vc = nextLevelVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func chooseColor(color: UIColor?) {
        guard let color = color else { return }
        
        myPalette.append(color)
        
        let myPaletteInColorGoups = palette.map({ clr in return myPalette.filter({ $0 == clr }) })
        
        guard myPaletteInColorGoups.first(where: { $0.count >= 3 }) == nil else {
            var stack = navigationController?.viewControllers
            stack?.removeSubrange(1...)
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "CSE Game", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CSECongratulationsController")
            
            stack?.append(vc)
            
            navigationController?.setViewControllers(stack!, animated: true)
            
            return
        }
        
        if let vc = nextLevelVC {
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CSEGameStoryboard") as! CSEViewController
            nextLevelVC = vc
            vc.previousLevelVC = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func levelTitle(_ lavel: Int) -> String {
        return "Level \(lavel)"
    }
}

extension CSEViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPalette.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaletteCollectionViewCellIdentifier", for: indexPath) as! CSEPaletteCollectionViewCell
        
        cell.confugure(with: myPalette[indexPath.row])
        
        return cell
    }
    
}
