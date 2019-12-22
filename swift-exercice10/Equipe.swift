//
//  Equipe.swift
//  swift-exercice10
//
//  Created by Didier Delhaye on 20/12/2019.
//  Copyright © 2019 Technifutur. All rights reserved.
//

import Foundation

class Equipe {
    let name: String
    let nbAssassinsMax = Int.random(in: 10...20)
    let nbMagiciensMax = Int.random(in: 15...25)
    
    var persos = [Personnage]()
    var nbPaladins = 0
    var nbMagiciens = 0
    var nbAssassins = 0
    
    init(name: String, nbPersoMax: Int = 100) {
        self.name = name
        for _ in 0..<nbPersoMax {
            if nbAssassins < nbAssassinsMax {
                nbAssassins += 1
                persos.append(Assassin(faction: name, number: nbAssassins))
            } else if nbMagiciens < nbMagiciensMax {
                nbMagiciens += 1
                persos.append(Magicien(faction: name, number: nbMagiciens))
            } else {
                nbPaladins += 1
                persos.append(Paladin(faction: name, number: nbPaladins))
            }
        }
        description()
    }
    
    // @TODO event listener qui check résultat de l’attaque
    func attaque(ennemi: Equipe) {
        if let perso1 = getFighter() {
            if let opponent1 = ennemi.getFighter() {
                if perso1 is Magicien {
                    let mago: Magicien = perso1 as! Magicien
                    if let hurtFighter = persos.first(where: { $0.name != mago.name && $0.isHurt() }) { // ne peut pas se soigner lui-même
                        mago.hurtFighter = hurtFighter
                    }
                }
                perso1.attaque(ennemi: opponent1)
            }
        }
    }
    
    func getFighter() -> Personnage? {
        return persos.randomElement()
    }
    
    func buryCorpse() {
        if let index = persos.firstIndex(where: { $0.isKilled() }) {
            print("\(persos[index].name) a rendu les armes...")
            persos.remove(at: index)
        }
    }
    
    func isStillFighting() -> Bool {
        return persos.count > 0
    }
    
    func nbSurvivants() -> Int {
        return persos.count
    }
    
    func description() {
        print("Équipe \(name): \(nbPaladins) paladins, \(nbMagiciens) magiciens, \(nbAssassins) assassins.")
    }
}
