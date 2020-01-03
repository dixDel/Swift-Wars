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
    
    var team: [Personnage] = [Personnage]()
    
    init(faction: String, number: Int) {
        super.init()
        name = "\(faction) - Mago\(number)"
        ptsArmureMax = Int.random(in: 25...50)
        ptsArmure = ptsArmureMax
        damageMin = 10
        damageMax = 25
        chanceCrit = 15
        critMultiplier = 4
    }
    
    override func criticalAction(originalDamage: Int) -> Int {
        var finalDamage = 0
        if !heal() {
            finalDamage = super.criticalAction(originalDamage: originalDamage)
        }
        return finalDamage
    }
    
    func heal() -> Bool {
        var hasHealed = false
        
        if let hurtFighter = getFighterToHeal() {
            let restored = self.ptsArmure * healRatio / 100
            hurtFighter.ptsArmure += restored
            print("HEAL ! \(name) a rendu \(restored) pts à \(hurtFighter.name): \(hurtFighter.ptsArmure)/\(hurtFighter.ptsArmureMax) pts d’armure.")
            hasHealed = true
        }
        
        return hasHealed
    }
    
    func getFighterToHeal() -> Personnage? {
        var fighterToHeal: Personnage?
        var percentLifeMin: Int = 100
        var percentLifeLeft: Int = 100
        print("\(name) vérifie s’il y a quelqu’un à soigner...")
        for fighter in team {
            if fighter.name != self.name { // mago ne peut pas se soigner lui-même
                percentLifeLeft = fighter.ptsArmure * 100 / fighter.ptsArmureMax
                print("\(fighter.name) a \(percentLifeLeft)% de points d’armure \(fighter.ptsArmure)/\(fighter.ptsArmureMax)")
                if percentLifeLeft < percentLifeMin {
                    percentLifeMin = percentLifeLeft
                    fighterToHeal = fighter
                // en cas d’égalité, heal celui qui a le moins de pts d’armure
                } else if percentLifeLeft < 100 && percentLifeLeft == percentLifeMin {
                    if fighter.ptsArmure < fighterToHeal!.ptsArmure { // on est certain d’avoir un fighterToHeal à ce stade
                        fighterToHeal = fighter
                    }
                }
            }
        }
        return fighterToHeal
    }
}
