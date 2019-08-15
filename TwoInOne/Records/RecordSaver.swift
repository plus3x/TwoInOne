//
//  RecordSaver.swift
//  TwoInOne
//
//  Created by Vladislav Petrov on 14/08/2019.
//  Copyright © 2019 Vladislav Petrov. All rights reserved.
//

import Foundation

class RecordSaver {
    enum GameName: String {
        case guessingGame, guessingGameTwo
    }
    
    static func save(_ newRecord: Record, toGame gameKey: GameName) {
        var records = try? get(fromGame: gameKey)
        
        let oldRecord = records?.first(where: { $0.number == newRecord.number })
        
        if let oldRecord = oldRecord {
            oldRecord.attempts = newRecord.attempts
        } else if records != nil {
            records!.append(newRecord)
        } else {
            records = [newRecord]
        }
        
        if let records = records {
            let data = try? NSKeyedArchiver.archivedData(withRootObject: records, requiringSecureCoding: false)
            
            UserDefaults.standard.set(data, forKey: gameKey.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func get(fromGame gameKey: GameName) throws -> [Record] {
        if let data = UserDefaults.standard.object(forKey: gameKey.rawValue) as? Data,
            let records = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Record] {
            return records
        } else {
            return []
        }
    }
    
    static private func decodeRecords() -> NSData {
        return NSData()
    }
    
    static private func encodeRecords() -> [Record] {
        return [Record]()
    }
}
