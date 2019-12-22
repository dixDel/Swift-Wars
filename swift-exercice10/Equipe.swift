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
        var team = getFightingTeam()
        var foes = ennemi.getFightingTeam()
        var isFoeFighting = true
        var cpt = 0
        
        while isFoeFighting && cpt < team.count {
            let fighter = team[cpt]
            // ordre d’attaque:
            // - Pal, Mag: Pal, Ass, Mag
            // - Ass: Mag, Pal, Ass
            if fighter is Paladin || fighter is Magicien {
                foes.sort { (perso1, perso2) -> Bool in
                    var isFirst = true
                    if perso1 is Assassin && perso2 is Paladin || perso1 is Magicien {
                            isFirst = false
                    }
                    return isFirst
                }
            } else {
                foes.sort { (perso1, perso2) -> Bool in
                    var isFirst = true
                    if perso1 is Paladin && perso2 is Magicien || perso1 is Assassin {
                        isFirst = false
                    }
                    return isFirst
                }
            }
            
            if let foe: Personnage = getOpponent(foes: foes) {
                if fighter is Magicien {
                    let mago: Magicien = fighter as! Magicien
                    if let hurtFighter = persos.first(where: { $0.name != mago.name && $0.isHurt() }) { // ne peut pas se soigner lui-même
                        mago.hurtFighter = hurtFighter
                    }
                }
                var ass: Assassin?
                if foe is Assassin {
                    ass = foe as? Assassin
                }
                if (ass == nil || !(ass?.evadeAttack(ennemi: fighter) ?? false)) {
                    fighter.attaque(ennemi: foe)
                }
            } else {
                print("Plus d’ennemis en état de combattre !")
                isFoeFighting = false
            }
            cpt += 1
        }
        
        dismissFightingTeam(team: &team)
        ennemi.dismissFightingTeam(team: &foes)
    }
    
    func getFightingTeam() -> [Personnage] {
        var team: [Personnage] = [Personnage]()
        var hasFighters = true
        var cpt = 0
        print("Équipe de \(name):")
        while hasFighters && cpt < fightingTeamSize {
            if let fighter = getFighter() {
                team.append(fighter)
                print("\(fighter.name)")
            } else {
                hasFighters = false
                print("Plus de combattants !")
            }
            cpt += 1
        }
        return team
    }
    
    func getFighter() -> Personnage? {
        var fighter: Personnage? = nil
        if persos.count > 0 {
            fighter = persos.remove(at: Int.random(in: 0..<persos.count))
        }
        return fighter
    }
    
    // foes ont été triés selon la classe du fighter dans la méthode attaque
    func getOpponent(foes: [Personnage]) -> Personnage? {
        return foes.first(where: {
            !$0.isKilled()
        })
    }
    
    func dismissFightingTeam(team: inout [Personnage]) {
        team.removeAll { (fighter) -> Bool in
            var isKilled = false
            if fighter.isKilled() {
                isKilled = true
                print("\(fighter.name) a rendu les armes...")
            }
            return isKilled
        }
        persos += team
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
