//
//  Paladin.swift
//  swift-exercice10
//
//  Created by Didier Delhaye on 20/12/2019.
//  Copyright © 2019 Technifutur. All rights reserved.
//

import Foundation

class Magicien: Personnage {
    
    let chanceHeal = 15
    let healRatio = 50 // 50% de son total de vie
    
    override init() {
        super.init()
        name = "Mago"
        ptsArmure = Int.random(in: 25...50)
        damageMin = 10
        damageMax = 25
        chanceCrit = 15
        critMultiplier = 4
    }
    
    override func attaque(ennemi: Personnage) {
        //@TODO check for alliés à soigner
        super.makeDamage(ennemi: ennemi)
    }
}
