//
//  MonsterService.swift
//  Monsters
//
//  Created by Sergey Melnikov on 16.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation
import RealmSwift

protocol MonsterService {
    var dataBase: Realm { get }
    
    var monsters: [Monster] { get }
    
    static func shared() -> MonsterService
    
    func resetDataBase()
    func openJSON() -> [Monster]
    func save(_ monster: Monster)
    
}
