//
//  main.swift
//  swift-exercice10
//
//  Created by Didier Delhaye on 20/12/2019.
//  Copyright © 2019 Technifutur. All rights reserved.
//

import Foundation

print("Swift Wars")
print("----------")

// init équipes: 100 persos/équipe
// > 10 à 20 Ass, 15 à 25 Mag, reste Pal
let lesBons = Equipe(name: "les bons")
let lesMauvais = Equipe(name: "les mauvais")

// chaque tour jusqu’à ce qu’une équipe n’ait plus de perso:
// 5 persos vs 5 persos (sélection aléatoire)
var isMatchEnded = false
var cptRound = 1
while !isMatchEnded {
    //@TODO fair-play: randomly choose first attacker
    print("Round \(cptRound)")
    lesBons.attaque(ennemi: lesMauvais)
    if lesMauvais.isStillFighting() {
        lesMauvais.attaque(ennemi: lesBons)
    }
    isMatchEnded = !lesBons.isStillFighting() || !lesMauvais.isStillFighting()
    cptRound += 1
    print()
}
print("Guerre terminée !")
print("Survivants: \(lesBons.nbSurvivants()) bons, \(lesMauvais.nbSurvivants()) mauvais.")

// Concerne pas ici, mais les classes respectives
// ordre priorité attaques:
// - Mag/Pal: paladins, assassins, magiciens
// - Ass: mag, pal, ass
// -- Attaque du mag: 15% de chances de soigner (50% de son total de vie) OU 15 %
