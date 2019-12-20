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
    
    func reduceArmor(damage: Int) {
        preconditionFailure("Must be overriden")
    }
    
    func isKilled() -> Bool {
        preconditionFailure("Must be overriden")
    }
}
