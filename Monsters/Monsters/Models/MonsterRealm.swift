//
//  MonsterRealm.swift
//  Monsters
//
//  Created by Sergey Melnikov on 22.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation
import RealmSwift

fileprivate let separator: Character = "❗️"
fileprivate let decoder = JSONDecoder()
fileprivate let encoder = JSONEncoder()

class MonsterRealm: Object, Codable {
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var fiction: String?
    @objc dynamic var size: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var source: String = ""
    @objc dynamic var alignment: String = ""
    @objc dynamic var ac: String = ""
    @objc dynamic var hp: String = ""
    @objc dynamic var speed: String = ""
    @objc dynamic var str: Int = 0
    @objc dynamic var dex: Int = 0
    @objc dynamic var con: Int = 0
    @objc dynamic var int: Int = 0
    @objc dynamic var wis: Int = 0
    @objc dynamic var cha: Int = 0
    @objc dynamic var save: String?
    @objc dynamic var vulnerable: String?
    @objc dynamic var skill: String?
    @objc dynamic var passive: Int = 0
    @objc dynamic var languages: String?
    @objc dynamic var cr: String = ""
    
    @objc dynamic var biomRealm: String = ""
    var biom: [String] {
        get { return biomRealm.split(separator: separator).map { String($0) }}
        set { biomRealm = newValue.joined(separator: String(separator)) }
    }
    
    @objc dynamic var subtypeRealm: String = ""
    var subtype: [String] {
        get { return subtypeRealm.split(separator: separator).map { String($0) }}
        set { subtypeRealm = newValue.joined(separator: String(separator)) }
    }
    
    @objc dynamic var conditionImmune: String?
    @objc dynamic var senses: String?
    @objc dynamic var immune: String?
    @objc dynamic var resist: String?
    @objc dynamic var spells: String?
    
    @objc dynamic var traitRealm: String = ""
    var trait: [String] {
        get { return traitRealm.split(separator: separator).map { String($0) }}
        set { traitRealm = newValue.joined(separator: String(separator)) }
    }
    
    @objc dynamic var actionRealm: String = ""
    var action: [String] {
        get { return actionRealm.split(separator: separator).map { String($0) }}
        set { actionRealm = newValue.joined(separator: String(separator)) }
    }
    
    @objc dynamic var reactionRealm: String = ""
    var reaction: [String] {
        get { return reactionRealm.split(separator: separator).map { String($0) }}
        set { reactionRealm = newValue.joined(separator: String(separator)) }
    }
    
    @objc dynamic var legendaryRealm: String = ""
    var legendary: [String] {
        get { return legendaryRealm.split(separator: separator).map { String($0) }}
        set { legendaryRealm = newValue.joined(separator: String(separator)) }
    }
    
    @objc dynamic var legendaryInfo: String?
    @objc dynamic var lair: String?
    @objc dynamic var local: String?
}

extension MonsterRealm {
    static func transform(_ monster: Monster) -> MonsterRealm {
        let result = MonsterRealm()
        result.name = monster.name
        result.image = monster.image.absoluteString
        result.fiction = monster.fiction
        result.size = monster.size.rawValue
        result.type = monster.type.rawValue
        result.source = monster.source
        result.alignment = monster.alignment.description
        result.ac = monster.ac
        result.hp = monster.hp.description
        result.speed = monster.speed
        result.str = monster.str
        result.dex = monster.dex
        result.con = monster.con
        result.int = monster.int
        result.wis = monster.wis
        result.cha = monster.cha
        result.save = monster.save
        result.vulnerable = monster.vulnerable
        result.skill = monster.skill
        result.passive = monster.passive
        result.languages = monster.languages
        result.cr = monster.cr
        result.biom = monster.biom.map({ $0.rawValue })
        result.subtype = monster.subtype
        result.conditionImmune = monster.conditionImmune
        result.senses = monster.senses
        result.immune = monster.immune
        result.resist = monster.resist
        result.spells = monster.spells
        
        result.trait = monster.trait.map {
            String(data: (try! encoder.encode($0)), encoding: .utf8)!
        }
        result.action = monster.action.map {
            String(data: (try! encoder.encode($0)), encoding: .utf8)!
        }
        result.reaction = monster.reaction.map {
            String(data: (try! encoder.encode($0)), encoding: .utf8)!
        }
        result.legendary = monster.legendary.map {
            String(data: (try! encoder.encode($0)), encoding: .utf8)!
        }
        
        result.legendaryInfo = monster.legendaryInfo
        
        if let lair = monster.lair {
            result.lair = String(data: try! encoder.encode(lair), encoding: .utf8)
        }
        if let local = monster.local {
            result.local = String(data: try! encoder.encode(local), encoding: .utf8)
        }
        
        return result
    }
}
