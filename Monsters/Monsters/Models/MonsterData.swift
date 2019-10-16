//
//  MonsterData.swift
//  Monsters
//
//  Created by Sergey Melnikov on 16.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation
import RealmSwift

class MonsterData: Object {
    @objc dynamic var data = Data()
    
    private static let encoder = JSONEncoder()
    private static let decoder = JSONDecoder()
    
    static func transform(_ monster: MonsterJSON) -> MonsterData {
        let result = MonsterData()
        result.data = try! encoder.encode(monster)
        return result
    }
    
    func transform() -> MonsterJSON {
        return try! MonsterData.decoder.decode(MonsterJSON.self, from: data)
    }
}
