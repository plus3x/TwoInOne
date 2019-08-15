//
//  Record.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 14/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import Foundation

class Record: NSObject, NSCoding {
    var number: Int
    var attempts: Int
    
    init(number: Int, attempts: Int) {
        self.number = number
        self.attempts = attempts
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let number = aDecoder.decodeInteger(forKey: "number")
        let attempts = aDecoder.decodeInteger(forKey: "attempts")
        self.init(number: number, attempts: attempts)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(number, forKey: "number")
        aCoder.encode(attempts, forKey: "attempts")
    }
}
