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
    
    enum ChoosedColor {
        case first, second, third, none
    }
    
    @IBOutlet weak var firstColorView: UIView!
    @IBOutlet weak var secondColorView: UIView!
    @IBOutlet weak var thirdColorView: UIView!
    @IBOutlet weak var myPaletteCollectionView: UICollectionView!
    
    let palette = [
        UIColor.blue,
        .red,
        .green,
    ]
    
    var lavel = 1
    var choosedColor: ChoosedColor = .none
    var myPalette = [UIColor]()
    weak var delegate: CSEViewController? = nil
    var nextLavelVC: CSEViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let delegate = delegate {
            lavel = delegate.lavel + 1
            myPalette = delegate.myPalette
            
            title = "Lavel \(lavel)"
            
            let barButton = UIBarButtonItem(
                title: "Lavel \(delegate.lavel)",
                style: .plain,
                target: self,
                action: #selector(onPreviousLavelTap(_:))
            )
            navigationItem.backBarButtonItem = barButton
        } else {
            let color = palette[Int.random(in: 0...(palette.count - 1))]!
            myPalette.append(color)
        }
        
        switch choosedColor {
        case .first:
            secondColorView.isHidden = true
            thirdColorView.isHidden = true
        case .second:
            firstColorView.isHidden = true
            thirdColorView.isHidden = true
        case .third:
            firstColorView.isHidden = true
            secondColorView.isHidden = true
        case .none: break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let nextLavelVC = nextLavelVC {
            let barButton = UIBarButtonItem(
                title: "Lavel \(nextLavelVC.lavel)",
                style: .plain,
                target: self,
                action: #selector(onForwardButtonTap(_:))
            )
            navigationItem.rightBarButtonItem = barButton
//            navigationItem.forwardingTarget(for: #selector(onForwardButtonTap(_:)))
        }
    }

    @IBAction func onHelpButtonTap(_ sender: Any) {
        performSegue(withIdentifier: "ShowHelp", sender: self)
    }
    
    @IBAction func onFirstColorViewTap(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.secondColorView.isHidden = true
            self.thirdColorView.isHidden = true
            self.loadViewIfNeeded()
        }, completion: { _ in
            self.chooseColor(color: self.firstColorView!.backgroundColor!)
        })
    }
    
    @IBAction func onSecondViewColorTap(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.firstColorView.isHidden = true
            self.thirdColorView.isHidden = true
            self.loadViewIfNeeded()
        }, completion: { _ in
            self.chooseColor(color: self.secondColorView!.backgroundColor!)
        })
    }
    
    @IBAction func onThirdColorViewTap(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.firstColorView.isHidden = true
            self.secondColorView.isHidden = true
            self.loadViewIfNeeded()
        }, completion: { _ in
            self.chooseColor(color: self.thirdColorView!.backgroundColor!)
        })
    }
    
    @objc private func onPreviousLavelTap(_ sender: Any?) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func onForwardButtonTap(_ sender: Any?) {
        if let vc = nextLavelVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowGZ", let vc = segue.destination as? UIViewController {
//            vc.navigationItem.backBarButtonItem = menuButton
//        }
//    }
    
    private func chooseColor(color: UIColor) {
        myPalette.append(color)
        
        let myPaletteInColorGoups = palette.map({ clr in return myPalette.filter({ $0 == clr }) })
        
        guard myPaletteInColorGoups.first(where: { $0.count >= 3 }) == nil else {
            var stack = navigationController?.viewControllers
            stack?.removeSubrange(2...)
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "CSE Game", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CSECongratulationsController")
            
            stack?.append(vc)
            
            navigationController?.setViewControllers(stack!, animated: true)
            
            return
        }
        
        if let vc = nextLavelVC {
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CSEGameStoryboard") as! CSEViewController
            nextLavelVC = vc
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
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
