//
//  Created by Didier Delhaye on 27/12/2019.
//  Copyright © 2019 Technifutur. All rights reserved.
//  

import Foundation

class Combat {
    
    let lesBons: Equipe
    let lesMauvais: Equipe
    
    var cptRound: Int = 1
    
    init() {
        // init équipes: 100 persos/équipe
        // > 10 à 20 Ass, 15 à 25 Mag, reste Pal
        lesBons = Equipe(name: "les bons")
        lesMauvais = Equipe(name: "les mauvais")
        print(lesBons)
        print(lesMauvais)
        print()
    }
    
    // 5 persos vs 5 persos (sélection aléatoire)
    func playRound() -> Bool {
        // init Equipes
        // lance attaques

        //@TODO fair-play: randomly choose first attacker
        //utiliser les mêmes équipes dans un round (défenseurs attaquent ensuite)
        print("Round \(cptRound)")
        lesBons.attaque(ennemi: lesMauvais)
        if lesMauvais.isStillFighting() {
            lesMauvais.attaque(ennemi: lesBons)
        }
        cptRound += 1
        print()
        return !lesBons.isStillFighting() || !lesMauvais.isStillFighting()
    }
    
    func showResults() {
        print("Survivants: \(lesBons.nbSurvivants()) bons, \(lesMauvais.nbSurvivants()) mauvais.")
    }
}
