//
//  Array.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 20/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import Foundation

// Add 'where' specification to avoid unused/legacy code when 'Pair' part of application will be removed
//extension Array where Element:Pair {
//    func chunked(into size: Int) -> [[Element]] {
//        return stride(from: 0, to: count, by: size).map {
//            Array(self[$0 ..< Swift.min($0 + size, count)])
//        }
//    }
//}
