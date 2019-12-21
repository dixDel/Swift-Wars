//
//  Paladin.swift
//  swift-exercice10
//
//  Created by Didier Delhaye on 20/12/2019.
//  Copyright © 2019 Technifutur. All rights reserved.
//

import Foundation

class Paladin: Personnage {

    init(faction: String, number: Int) {
        super.init()
        name = "\(faction): Pal\(number)"
        ptsArmureMax = Int.random(in: 100...150)
        ptsArmure = ptsArmureMax
        damageMin = 2
        damageMax = 5
        chanceCrit = 5
        critMultiplier = 2
    }
    
}
