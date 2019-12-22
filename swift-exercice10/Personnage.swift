//
//  Personnage.swift
//  swift-exercice10
//
//  Created by Didier Delhaye on 20/12/2019.
//  Copyright © 2019 Technifutur. All rights reserved.
//

import Foundation

class Personnage: ClassePersonnage {    
    var name: String = ""
    var damageMin: Int = 0
    var damageMax: Int = 0
    
    var ptsArmureMax: Int = 0 // {
        //willSet(newValue) { // not called at first init...
            //ptsArmure = newValue
        //}
    //}
    var _ptsArmure: Int = 0
    var ptsArmure: Int {
        get {
            return _ptsArmure
        }
        set(newValue) {
            if newValue > ptsArmureMax {
                _ptsArmure = ptsArmureMax
            } else {
                _ptsArmure = newValue
            }
        }
    }
    
    var ptsAttaque: Int = 0
    var chanceCrit: Int = 0
    var critMultiplier: Int = 0
    
    var xp: Double = 0
    
    func attaque(ennemi: Personnage) {
        var damage = Int.random(in: damageMin...damageMax)
        if Int.random(in: 1...100) <= chanceCrit {
            damage = criticalAction(originalDamage: damage)
        }
        if damage > 0 {
            print("\(name) a infligé à \(ennemi.name) \(damage) pts de dommage")
            ennemi.reduceArmor(damage: damage)
        }
    }
    
    func criticalAction(originalDamage: Int) -> Int {
        print("Coup CRITIQUE !")
        return originalDamage * critMultiplier
    }
    
    func reduceArmor(damage: Int) {
        ptsArmure -= damage
        print("\(name) a \(ptsArmure)/\(ptsArmureMax) pts d’armure.")
    }
    
    func isHurt() -> Bool {
        return ptsArmure < ptsArmureMax
    }
    
    func isKilled() -> Bool {
        return ptsArmure <= 0
    }
}
