//
//  MonstersTests.swift
//  MonstersTests
//
//  Created by Sergey Melnikov on 14.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import XCTest
@testable import Monsters

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

}
