//
//  Equipe.swift
//  swift-exercice10
//
//  Created by Didier Delhaye on 20/12/2019.
//  Copyright © 2019 Technifutur. All rights reserved.
//

import Foundation

protocol FighterDelegate {
    func takeABlow()
}

class Equipe: CustomStringConvertible {
    let name: String
    let nbAssassinsMax = Int.random(in: 10...20)
    let nbMagiciensMax = Int.random(in: 15...25)
    let fightingTeamSize = 5
    let honorSentences: [String: [String]] = [
        "Paladin": [
            "%@ a rendu l’âme...",
            "%@ a rendu les armes...",
            "%@ n’est plus, honorez sa mémoire !",
            "%@ mange les pissenlits par la racine.",
            "Rest in pieces, %@"
        ],
        "Magicien": [
            "%@ n’est plus, son bâton s’est brisé...",
            "Non, tu n’étais pas Gandalf, %@.",
            "%@ a déversé toute sa mana..."
        ],
        "Assassin": [
            "Celle-là a eu du mal à passer, %@ !",
            "%@ est au fond du trou.",
            "Personne ne se souviendra de ce fourbe %@..."
        ]
    ]
    
    var fighters = [Personnage]()
    var nbPaladins = 0
    var nbMagiciens = 0
    var nbAssassins = 0
    private var fightingTeam = [Personnage]()

    var description: String {
        return "Équipe \(name): \(nbPaladins) paladins, \(nbMagiciens) magiciens, \(nbAssassins) assassins."
    }
    
    init(name: String, nbPersoMax: Int = 100) {
        self.name = name
        for _ in 0..<nbPersoMax {
            if nbAssassins < nbAssassinsMax {
                nbAssassins += 1
                fighters.append(Assassin(faction: name, number: nbAssassins))
            } else if nbMagiciens < nbMagiciensMax {
                nbMagiciens += 1
                fighters.append(Magicien(faction: name, number: nbMagiciens))
            } else {
                nbPaladins += 1
                fighters.append(Paladin(faction: name, number: nbPaladins))
            }
        }
    }
    
    // @TODO event listener qui check résultat de l’attaque
    // event listener sur Assassin: quand attaqué, tente une esquive
    func attack(foeTeam: [Personnage]) {
        var isFoeFighting = true
        var cnt = 0
        
        print("L’attaque de \"\(name)\" commence !")
        while isFoeFighting && cnt < fightingTeam.count {
            let fighter = fightingTeam[cnt]
            
            let sortedFoes = sortFoes(fighter: fighter, foes: foeTeam)
            
            isFoeFighting = attackFoe(fighter: fighter, foes: sortedFoes)
            
            cnt += 1
        }
    }
    
    func attackFoe(fighter: Personnage, foes: [Personnage]) -> Bool {
        var isFoeFighting = true
        
        if let foe: Personnage = getOpponent(foes: foes) {
            
            fighter.delegate = foe
            
            if fighter is Magicien {
                let mago: Magicien = fighter as! Magicien
                mago.team = fightingTeam
            }
            fighter.attack(ennemi: foe)
            giveHonorsTo(fighter: foe)
        } else {
            print("Plus d’ennemis en état de combattre !")
            isFoeFighting = false
        }
        return isFoeFighting
    }
    
    func sortFoes(fighter: Personnage, foes: [Personnage]) -> [Personnage] {
        var sortedFoes = foes
        // ordre d’attaque:
        // - Pal, Mag: Pal, Ass, Mag
        // - Ass: Mag, Pal, Ass
        if fighter is Paladin || fighter is Magicien {
            sortedFoes.sort { (perso1, perso2) -> Bool in
                var isFirst = true
                if perso1 is Assassin && perso2 is Paladin || perso1 is Magicien {
                        isFirst = false
                }
                return isFirst
            }
        } else {
            sortedFoes.sort { (perso1, perso2) -> Bool in
                var isFirst = true
                if perso1 is Paladin && perso2 is Magicien || perso1 is Assassin {
                    isFirst = false
                }
                return isFirst
            }
        }
        return sortedFoes
    }
    
    func getFightingTeam() -> [Personnage] {
        if fightingTeam.isEmpty && !fighters.isEmpty {
            var team = [Personnage]()
            var hasFighters = true
            var cnt = 0
            print("Équipe de \"\(name)\":")
            while hasFighters && cnt < fightingTeamSize {
                if let fighter = getFighter() {
                    team.append(fighter)
                    print(fighter)
                } else {
                    hasFighters = false
                    print("Plus de combattants !")
                }
                cnt += 1
            }
            fightingTeam = team
        }
        return fightingTeam
    }
    
    func getFighter() -> Personnage? {
        var fighter: Personnage? = nil
        if fighters.count > 0 {
            fighter = fighters.remove(at: Int.random(in: 0..<fighters.count))
        }
        return fighter
    }
    
    // foes ont été triés selon la classe du fighter dans la méthode attaque
    func getOpponent(foes: [Personnage]) -> Personnage? {
        return foes.first(where: {
            !$0.isKilled()
        })
    }
    
    func buryTheDeads() {
        fightingTeam.removeAll {
            $0.isKilled()
        }
    }
    
    func dismissFightingTeam() {
        fighters += fightingTeam
        fightingTeam.removeAll()
    }
    
    func isStillFighting() -> Bool {
        return fighters.count > 0
    }
    
    func nbSurvivants() -> Int {
        return fighters.count
    }
    
    func giveHonorsTo(fighter: Personnage) {
        if fighter.isKilled() {
            print(String(format: honorSentences["\(type(of: fighter))"]!.randomElement()!, fighter.name))
        }
    }
}
