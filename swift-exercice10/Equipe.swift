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
    let fightingTeamSize = 5
    
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
    // event listener sur Assassin: quand attaqué, tente une esquive
    func attaque(ennemi: Equipe) {
        if let perso1 = getFighter() {
            if let opponent1 = ennemi.getFighter() {
                if perso1 is Magicien {
                    let mago: Magicien = perso1 as! Magicien
                    if let hurtFighter = persos.first(where: { $0.name != mago.name && $0.isHurt() }) { // ne peut pas se soigner lui-même
                        mago.hurtFighter = hurtFighter
                    }
                }
                var ass: Assassin?
                if opponent1 is Assassin {
                    ass = opponent1 as? Assassin
                }
                if (ass == nil || !(ass?.evadeAttack(ennemi: perso1) ?? false))  {
                    perso1.attaque(ennemi: opponent1)
                }
            }
        }
    }
    
    func getFightingTeam() -> [Personnage] {
        var team: [Personnage] = [Personnage]()
        for _ in 1...fightingTeamSize {
            if let fighter = getFighter() {
                team.append(fighter)
            } else {
                print("L’équipe \(name) n’a pas assez de combattants: \(persos.count) !")
            }
        }
        return team
    }
    
    func getFighter() -> Personnage? {
        return persos.remove(at: Int.random(in: 0...persos.count))
    }
    
    func dismissFightingTeam(team: [Personnage]) {
        persos.append(contentsOf: team)
    }
    
    func buryCorpses() {
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
