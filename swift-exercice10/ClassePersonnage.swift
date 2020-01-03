//
//  ClassePersonnage.swift
//  swift-exercice10
//
//  Created by Didier Delhaye on 20/12/2019.
//  Copyright © 2019 Technifutur. All rights reserved.
//

import Foundation

protocol ClassePersonnage {
    var name: String { get }
    var ptsArmureMax: Int { get }
    
    var ptsArmure: Int { get set }
    var ptsAttaque: Int { get set }
    var chanceCrit: Int { get set }
    var critMultiplier: Int { get set }
    var xp: Double { get set }
    var damageMin: Int { get set }
    var damageMax: Int { get set }
    
    func attack(ennemi: Personnage)
    
    func reduceArmor(damage: Int)
    
    func isHurt() -> Bool
    
    func isKilled() -> Bool
}
