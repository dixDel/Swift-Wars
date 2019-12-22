//
//  Assassin.swift
//  swift-exercice10
//
//  Created by Didier Delhaye on 22/12/2019.
//  Copyright © 2019 Technifutur. All rights reserved.
//

import Foundation

class Assassin: Personnage {
    
    let chanceEvade = 15
    
    init(faction: String, number: Int) {
        super.init()
        name = "\(faction): Assassin\(number)"
        ptsArmureMax = Int.random(in: 35...75)
        ptsArmure = ptsArmureMax
        damageMin = 15
        damageMax = 30
        chanceCrit = 30
        critMultiplier = 2
    }
    
    func evadeAttack(ennemi: Personnage) -> Bool {
        var evadeAttack = false
        if Int.random(in: 1...100) <= chanceEvade {
            evadeAttack = true
            print("\(name) a esquivé l’attaque de \(ennemi.name)!")
        }
        return evadeAttack
    }
    
}
