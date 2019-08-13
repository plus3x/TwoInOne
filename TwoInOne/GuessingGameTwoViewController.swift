//
//  GuessingGameTwoViewController.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 12/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

class GuessingGameTwoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var attemptsCountLabel: UILabel!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var exactlyButton: UIButton!
    @IBOutlet weak var greaterButton: UIButton!
    @IBOutlet weak var lessButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    var number: Int = 0
    var attempts: Int = 0
    var guess: Int = 0
    var guessMin: Int = 1
    var guessMax: Int = 1_000_000
    
    enum Guess {
        case new
        case less
        case greater
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberField.delegate = self
        numberField.becomeFirstResponder()
        
        setGuessingMenu(enabled: false)
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let number: Int = Int(numberField.text ?? "-1"), (1...1_000_000).contains(number) else {
            showAlert("You need to enter correct value. Number must be in range between 1 to 1 000 000")
            return true
        }
        
        self.number = number
        
        numberField.resignFirstResponder()
        
        setNumberMenu(enabled: false)
        setGuessingMenu(enabled: true)
        
        calculateGuess(.new)
        
        return true
    }
    
    @IBAction func onOkButtonTap(_ sender: Any) {
        _ = textFieldShouldReturn(numberField)
    }
    
    @IBAction func onLessButtonTap(_ sender: Any) {
        calculateGuess(.less)
    }
    
    @IBAction func onExactlyButtonTap(_ sender: Any) {
        showAlert("I've calculate guess in \(attempts) steps")
    }
    
    @IBAction func onGreaterButtonTap(_ sender: Any) {
        calculateGuess(.greater)
    }
    
    private func calculateGuess(_ guessResult: Guess) {
        increeseAttempts()
        
        switch guessResult {
        case .new: break
        case .less: guessMin = guess
        case .greater: guessMax = guess
        }
        
        guess = Int.random(in: (guessMin + 1) ..< guessMax)
        
        guessLabel.text = "\(guess)"
    }
    
    private func showAlert(_ msg: String) {
        let alert = UIAlertController(
            title: nil,
            message: msg,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func setNumberMenu(enabled: Bool) {
        okButton.isEnabled = enabled
        numberField.isEnabled = enabled
    }
    
    private func setGuessingMenu(enabled: Bool) {
        guessLabel.isHidden = !enabled
        attemptsLabel.isHidden = !enabled
        attemptsCountLabel.isHidden = !enabled
        lessButton.isEnabled = enabled
        exactlyButton.isEnabled = enabled
        greaterButton.isEnabled = enabled
    }
    
    private func increeseAttempts() {
        attempts += 1
        attemptsCountLabel.text = "\(attempts)"
    }
}
