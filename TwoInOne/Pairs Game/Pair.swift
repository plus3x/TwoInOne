//
//  Point.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 20/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import UIKit

class Pair {
    enum State: String {
        case normal
        case selecting, selected
        case deselecting
        case collapsing
    }
    
    let index: Int
    let color: UIColor?
    var state: State = .normal
    
    init(index: Int, color: UIColor?) {
        self.index = index
        self.color = color
    }
}
