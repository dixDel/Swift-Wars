//
//  Magicien.swift
//  swift-exercice10
//
//  Created by Didier Delhaye on 20/12/2019.
//  Copyright © 2019 Technifutur. All rights reserved.
//

import Foundation

class Magicien: Personnage {
    
    //let chanceHeal = 15 // identique à chanceCrit
    let healRatio = 50 // 50% de son total de vie
    
    var hurtFighter: Personnage?
    
    init(faction: String, number: Int) {
        super.init()
        name = "\(faction): Mago\(number)"
        ptsArmureMax = Int.random(in: 25...50)
        ptsArmure = ptsArmureMax
        damageMin = 10
        damageMax = 25
        chanceCrit = 15
        critMultiplier = 4
    }
    
    override func criticalAction(originalDamage: Int) -> Int {
        var finalDamage = 0
        if hurtFighter != nil {
            heal()
        } else {
            finalDamage = super.criticalAction(originalDamage: originalDamage)
        }
        return finalDamage
    }
    
    func heal() {
        print("HEAL !")
        let restored = self.ptsArmure * healRatio / 100
        hurtFighter!.ptsArmure += restored
        print("\(name) a rendu \(restored) pts à \(hurtFighter!.name): \(hurtFighter!.ptsArmure)/\(hurtFighter!.ptsArmureMax) pts d’armure.")
    }
}
