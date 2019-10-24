//
//  MonstersTests.swift
//  MonstersTests
//
//  Created by Sergey Melnikov on 14.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import XCTest
@testable import Monsters

fileprivate let separator: Character = "❗️"
class MonstersTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        let monsterService = MonsterServiceImpl.shared()
        XCTAssert(monsterService.monsters.count > 100)
    }
    
    func testExport() {
        let monsterService = MonsterServiceImpl.shared()
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("TestExport")
        do {
            try MonsterServiceImpl.export(url, objects: monsterService.monsters.map{ MonsterJSON($0) })
            XCTAssert(true)
        } catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testImport() {
        testExport()
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("TestExport")
        do {
            let monsters: [MonsterJSON] = try MonsterServiceImpl.import(url)
            XCTAssert(monsters.count > 100)
        } catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testSave() {
        let monster = Monster(name: "TEST", image: URL(string: "http://ya.ru")!, fiction: "", size: .G, type: .aberration, source: "TEST", alignment: .other(desc: "TEST"), ac: "TEST", hp: Hp(dices: Hp.Dice(dice: 4, count: 2)), speed: "TEST", str: 0, dex: 0, con: 0, int: 0, wis: 0, cha: 0, save: "", vulnerable: "", skill: "", passive: 0, languages: "", cr: "", biom: [], subtype: [], conditionImmune: "", senses: "", immune: "", resist: "", spells: "", trait: [], action: [], reaction: [], legendary: [], legendaryInfo: "", lair: nil, local: nil)
        let monsterService = MonsterServiceImpl.shared()
        monsterService.save(monster)
        let result = monsterService.monsters.first { $0.name == "TEST"}
        XCTAssert(result != nil)
    }
    
    func testOpenJSON() {
        let monsterService = MonsterServiceImpl.shared()
        let monster = monsterService.openJSON()
        XCTAssert(monster.count > 0)
    }

    func testTransform() {
        let monster = Monster(name: "Test", image: URL(string: "https://ya.ru")!, fiction: "Fiction", size: .G, type: .celestial, source: "MT", alignment: .chaoticEvil, ac: "500", hp: Hp(200, dices: Hp.Dice(dice: 20, count: 20), bonus: 100), speed: "speed", str: 333, dex: 333, con: 333, int: 333, wis: 333, cha: 333, save: "save", vulnerable: "vulnerable", skill: "skill", passive: 444, languages: "languages", cr: "cr", biom: [.arctic], subtype: ["subtype"], conditionImmune: "conditionImmune", senses: "senses", immune: "immune", resist: "resist", spells: "spells", trait: [Monster.Action(name: "Trait", text: "1", attack: ["1"]), Monster.Action(name: "Trait2", text: "1", attack: ["1"])], action: [Monster.Action(name: "Action", text: "1", attack: ["1"])], reaction: [Monster.Action(name: "Reaction", text: "1", attack: ["1"])], legendary: [Monster.Action(name: "Legendary", text: "1", attack: ["1"])], legendaryInfo: "legInfo", lair: Monster.Location(text: "La❗️ir", list: ["1"]), local: Monster.Location(text: "Local", list: ["1"]))
        let monsterRealm = MonsterRealm.transform(monster)
        if monsterRealm.name != "Test" {
            XCTAssert(false)
        }
        if monsterRealm.image != "https://ya.ru" {
            XCTAssert(false)
        }
        if monsterRealm.fiction != "Fiction" {
            XCTAssert(false)
        }
        if monsterRealm.size != "G" {
            XCTAssert(false)
        }
        if monsterRealm.type != "небожитель" {
            XCTAssert(false)
        }
        if monsterRealm.source != "MT" {
            XCTAssert(false)
        }
        if monsterRealm.alignment != "хаотично-злое" {
            XCTAssert(false)
        }
        if monsterRealm.ac != "500" {
            XCTAssert(false)
        }
        if monsterRealm.hp != "200 (20к20 + 100)" {
            XCTAssert(false)
        }
        if monsterRealm.speed != "speed" {
            XCTAssert(false)
        }
        if monsterRealm.str != 333 {
            XCTAssert(false)
        }
        if monsterRealm.dex != 333 {
            XCTAssert(false)
        }
        if monsterRealm.con != 333 {
            XCTAssert(false)
        }
        if monsterRealm.int != 333 {
            XCTAssert(false)
        }
        if monsterRealm.wis != 333 {
            XCTAssert(false)
        }
        if monsterRealm.cha != 333 {
            XCTAssert(false)
        }
        if monsterRealm.save != "save" {
            XCTAssert(false)
        }
        if monsterRealm.vulnerable != "vulnerable" {
            XCTAssert(false)
        }
        if monsterRealm.skill != "skill" {
            XCTAssert(false)
        }
        if monsterRealm.passive != 444 {
            XCTAssert(false)
        }
        if monsterRealm.languages != "languages" {
            XCTAssert(false)
        }
        if monsterRealm.cr != "cr" {
            XCTAssert(false)
        }
        if monsterRealm.biomRealm != "ARCTIC" {
            XCTAssert(false)
        }
        if monsterRealm.subtypeRealm != "subtype" {
            XCTAssert(false)
        }
        if monsterRealm.conditionImmune != "conditionImmune" {
            XCTAssert(false)
        }
        if monsterRealm.senses != "senses" {
            XCTAssert(false)
        }
        if monsterRealm.immune != "immune" {
            XCTAssert(false)
        }
        if monsterRealm.resist != "resist" {
            XCTAssert(false)
        }
        if monsterRealm.spells != "spells" {
            XCTAssert(false)
        }
        if monsterRealm.legendaryInfo != "legInfo" {
            XCTAssert(false)
        }
        if monsterRealm.lair != "{\"text\":\"La❗️ir\",\"list\":[\"1\"]}" {
            XCTAssert(false, monsterRealm.lair ?? "--")
        }
        if let lair = monsterRealm.lair {
            if let data = lair.data(using: .utf8), let lairTmp = try? JSONDecoder().decode(Monster.Location.self, from: data) {
                print(lairTmp)
            } else {
                XCTAssert(false)
            }
        } else {
            XCTAssert(false, monsterRealm.lair ?? "--")
        }
        XCTAssert(true)
        
    }
}
