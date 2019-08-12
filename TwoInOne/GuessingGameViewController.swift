//
//  GuessingGameViewController.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 12/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

class GuessingGameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var guessField: UITextField!
    let randomNumber: Int = Int.random(in: 0 ..< 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guessField.delegate = self
    }
    
    @IBAction func onOkTap(_ sender: Any) {
        _ = textFieldShouldReturn(guessField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guessField.resignFirstResponder()
        
        guard let number: Int = Int(guessField.text ?? "") else {
            showAlert("Wrong value")
            return true
        }
        
        switch number {
        case _ where number < randomNumber:
            showAlert("Less!")
        case _ where number > randomNumber:
            showAlert("Greater!")
        case randomNumber:
            showAlert("Exactly!!!")
        default:
            showAlert("Wrong value")
        }
        
        return true
    }
    
    private func showAlert(_ msg: String) {
        let alert = UIAlertController(
            title: nil,
            message: msg,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        
        present(alert, animated: true)
    }
}
