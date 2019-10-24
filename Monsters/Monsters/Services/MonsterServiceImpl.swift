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
        get { dataBase.objects(MonsterRealm.self).map { Monster($0) } }
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
        let monsterRealm = MonsterRealm.transform(monster)
        try! dataBase.write {
            dataBase.add(monsterRealm)
        }
    }
    
    func openJSON() -> [Monster] {
        guard let url = Bundle.main.url(forResource: "Monsters", withExtension: "json") else { fatalError("Отсутствует файл Spell.json в Bundle") }
        let monsterJSON: [MonsterRealm] = try! MonsterServiceImpl.import(url)
        return monsterJSON.map { Monster($0) }
    }
    
    func resetDataBase() {
        guard let url = Bundle.main.url(forResource: "Monsters", withExtension: "json") else { fatalError("Отсутствует файл Spell.json в Bundle") }
        do {
            let monstersRealm: [MonsterRealm] = try MonsterServiceImpl.import(url)
            try dataBase.write {
                dataBase.deleteAll()
                dataBase.add(monstersRealm)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Init
    private init() {
        dataBase = try! Realm(configuration: Realm.Configuration.defaultConfiguration)
        if dataBase.objects(MonsterRealm.self).count == 0 {
            resetDataBase()
        }
    }
}

// MARK: - Exported And Imported
extension MonsterServiceImpl: Exported, Imported {}
