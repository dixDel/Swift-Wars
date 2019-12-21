//
//  Paladin.swift
//  swift-exercice10
//
//  Created by Didier Delhaye on 20/12/2019.
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
        super.makeDamage(ennemi: ennemi)
    }
}
