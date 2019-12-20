//
//  Paladin.swift
//  swift-exercice10
//
//  Created by Vagrant on 20/12/2019.
//  Copyright © 2019 Technifutur. All rights reserved.
//

import Foundation

class Paladin: Personnage {
    
    override init() {
        super.init()
        name = "Pal"
        ptsArmure = Int.random(in: 100...150)
        damageMin = 2
        damageMax = 5
        chanceCrit = 5
        critMultiplier = 2
    }
    
    override func attaque(ennemi: Personnage) {
        var damage = Int.random(in: damageMin...damageMax)
        if Int.random(in: 1...100) <= chanceCrit {
            damage = damage * 2
            print("\(name) a infligé un coup CRITIQUE !")
        }
        ennemi.reduceArmor(damage: damage)
    }
    
    override func reduceArmor(damage: Int) {
        ptsArmure -= damage
        print("\(damage) pts de dommage")
    }
    
    override func isKilled() -> Bool {
        return ptsArmure <= 0
    }
}
