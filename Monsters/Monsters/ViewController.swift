//
//  ViewController.swift
//  Monsters
//
//  Created by Sergey Melnikov on 14.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let service = MonsterServiceImpl.shared()
        print(service.monsters.count)
        let monster = service.openJSON()
        let monsterRealm = monster.map { MonsterRealm.transform($0) }
        let fileManager = FileManager.default
        var url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        url.appendPathComponent("Monster.json")
        print(url.absoluteString)
        try! MonsterServiceImpl.export(url, objects: monsterRealm)
    }
}
