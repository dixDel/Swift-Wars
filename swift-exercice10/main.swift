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

var fight:Combat = Combat()
var isMatchEnded = false

// chaque tour jusqu’à ce qu’une équipe n’ait plus de perso
while !isMatchEnded {
    isMatchEnded = fight.playRound()
}
print("Guerre terminée !")
fight.showResults()
