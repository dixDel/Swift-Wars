//
//  main.swift
//  swift-exercice10
//
//  Created by Didier Delhaye on 20/12/2019.
//  Copyright © 2019 Technifutur. All rights reserved.
//

import Foundation

print("Hello, World of War!")

// init équipes: 100 persos/équipe
// > 10 à 20 Ass, 15 à 25 Mag, reste Pal
let lesBons = Equipe(name: "les bons")
let lesMauvais = Equipe(name: "les mauvais")

// chaque tour jusqu’à ce qu’une équipe n’ait plus de perso:
// 5 persos vs 5 persos (sélection aléatoire)
// paladin1.attaque()
var isMatchEnded = false
while !isMatchEnded {
    //@TODO fair-play: randomly choose first attacker
    lesBons.attaque(ennemi: lesMauvais)
    lesMauvais.attaque(ennemi: lesBons)
    lesBons.buryCorpse()
    lesMauvais.buryCorpse()
    isMatchEnded = !lesBons.isStillFighting() || !lesMauvais.isStillFighting()
}
print("Guerre terminée !")
print("Survivants: \(lesBons.nbSurvivants()) bons, \(lesMauvais.nbSurvivants()) mauvais.")

// Concerne pas ici, mais les classes respectives
// ordre priorité attaques:
// - Mag/Pal: paladins, assassins, magiciens
// - Ass: mag, pal, ass
// -- Attaque du mag: 15% de chances de soigner (50% de son total de vie) OU 15 %
