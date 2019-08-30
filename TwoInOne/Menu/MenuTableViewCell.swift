//
//  MenuTableViewCell.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 18/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    static let identifier = "MenuTableViewCellIdentifier"
    
    @IBOutlet weak var menuItemLabel: UILabel!
    
    var menuItem: MenuItem!
 
    func configure(with menuItem: MenuItem) {
        self.menuItem = menuItem
        
        menuItemLabel.text = menuItem.name
        
        if menuItem.selected {
            markAsSelected()
        } else {
            markAsDeselected()
        }
    }
    
    private func markAsSelected() {
        menuItemLabel.textColor = .orangeCustom
    }
    
    private func markAsDeselected() {
        menuItemLabel.textColor = .mainText
    }
}
