//
//  Personnage.swift
//  swift-exercice10
//
//  Created by Vagrant on 20/12/2019.
//  Copyright © 2019 Technifutur. All rights reserved.
//

import Foundation

class Personnage: ClassePersonnage {
    var name: String = ""
    var damageMin: Int = 0
    var damageMax: Int = 0
    
    var ptsArmure: Int = 0
    var ptsAttaque: Int = 0
    
    var chanceCrit: Int = 0
    var critMultiplier: Int = 0
    
    var xp: Double = 0
    
    func attaque(ennemi: Personnage) {
        preconditionFailure("Must be overriden")
    }
    
    func makeDamage(ennemi: Personnage) {
        var damage = Int.random(in: damageMin...damageMax)
        if Int.random(in: 1...100) <= chanceCrit {
            damage = damage * critMultiplier
            print("\(name) a infligé un coup CRITIQUE !")
        }
        print("\(name) a infligé à \(ennemi.name) \(damage) pts de dommage")
        ennemi.reduceArmor(damage: damage)
    }
    
    func reduceArmor(damage: Int) {
        ptsArmure -= damage
        print("\(name) a \(ptsArmure) pts d’armure.")
    }
    
    func isKilled() -> Bool {
        return ptsArmure <= 0
    }
}
