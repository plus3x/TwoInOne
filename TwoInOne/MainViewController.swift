//
//  MainViewController.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 12/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBAction func onGuessingGameButtonTap(_ sender: Any) {
        self.performSegue(withIdentifier: "ShowGuessingGameVC", sender: self)
    }
}
