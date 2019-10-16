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
        // Do any additional setup after loading the view.
    }


}

