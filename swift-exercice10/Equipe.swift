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
    let nbMagiciensMax = Int.random(in: 15...25)
    
    var persos = [Personnage]()
    var nbPaladins = 0
    var nbMagiciens = 0
    
    init(name: String, nbPersoMax: Int = 100) {
        self.name = name
        for _ in 0..<nbPersoMax {
            if nbMagiciens < nbMagiciensMax {
                persos.append(Magicien())
                nbMagiciens += 1
            } else {
                persos.append(Paladin())
                nbPaladins += 1
            }
        }
        description()
    }
    
    // @TODO event listener qui check résultat de l’attaque
    func attaque(ennemi: Equipe) {
        if let perso1 = getFighter() {
            if let opponent1 = ennemi.getFighter() {
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
        print("L’équipe \(name) est composée de \(nbPaladins) paladins et de \(nbMagiciens) magiciens.")
    }
}
