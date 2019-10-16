//
//  MonsterServiceImpl.swift
//  Monsters
//
//  Created by Sergey Melnikov on 16.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation
import RealmSwift

class MonsterServiceImpl: MonsterService {
    
    // MARK: - Properties
    var dataBase: Realm
    var monsters: [Monster] {
        get { dataBase.objects(MonsterData.self).map { Monster($0.transform()) } }
    }
    
    private static var service: MonsterService?
    static func shared() -> MonsterService {
        if service == nil {
            service = MonsterServiceImpl()
        }
        return service!
    }
    
    // MARK: - Methods
    func save(_ monster: Monster) {
        let monsterData = MonsterData.transform(MonsterJSON(monster))
        try! dataBase.write {
            dataBase.add(monsterData)
        }
    }
    
    func resetDataBase() {
        guard let url = Bundle.main.url(forResource: "Monsters", withExtension: "json") else { fatalError("Отсутствует файл Spell.json в Bundle") }
        do {
            let monstersJSON: [MonsterJSON] = try MonsterServiceImpl.import(url)
            let monstersData = monstersJSON.map { MonsterData.transform($0) }
            try dataBase.write {
                dataBase.delete(dataBase.objects(MonsterData.self))
                dataBase.add(monstersData)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Init
    private init() {
        dataBase = try! Realm(configuration: Realm.Configuration.defaultConfiguration)
        if dataBase.objects(MonsterData.self).count == 0 {
            resetDataBase()
        }
    }
}

// MARK: - Exported And Imported
extension MonsterServiceImpl: Exported, Imported {}
