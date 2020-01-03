//
//  Created by Didier Delhaye on 27/12/2019.
//  Copyright © 2019 Technifutur. All rights reserved.
//  

import Foundation

class Combat {
    
    let lesBons: Equipe
    let lesMauvais: Equipe
    
    var cptRound: Int = 0
    var firstAttacker: Equipe
    var secondAttacker: Equipe
    
    init() {
        // init équipes: 100 persos/équipe
        // > 10 à 20 Ass, 15 à 25 Mag, reste Pal
        lesBons = Equipe(name: "les bons")
        lesMauvais = Equipe(name: "les mauvais")
        firstAttacker = lesBons
        secondAttacker = lesMauvais
        print(lesBons)
        print(lesMauvais)
        print()
    }
    
    // 5 persos vs 5 persos (sélection aléatoire)
    func playRound() -> Bool {
        cptRound += 1
        print("Round \(cptRound)")
        
        drawTurns()
        
        firstAttacker.getFightingTeam()
        secondAttacker.getFightingTeam()
        
        launchAttack(teamA: firstAttacker, teamB: secondAttacker)
        
        if secondAttacker.isStillFighting() {
            print("Riposte !")
            launchAttack(teamA: secondAttacker, teamB: firstAttacker)
        }
        
        firstAttacker.dismissFightingTeam()
        secondAttacker.dismissFightingTeam()
        
        print()
        return !firstAttacker.isStillFighting() || !secondAttacker.isStillFighting()
    }
    
    func launchAttack(teamA: Equipe, teamB: Equipe) {
        teamA.attack(foeTeam: teamB.getFightingTeam())
        teamB.buryTheDeads()
    }
    
    func showResults() {
        print("Survivants après \(cptRound) rounds : \(lesBons.nbSurvivants()) bons, \(lesMauvais.nbSurvivants()) mauvais.")
    }
    
    func drawTurns() {
        switch Int.random(in: 0...1) {
        case 1:
            firstAttacker = lesMauvais
            secondAttacker = lesBons
        default:
            firstAttacker = lesBons
            secondAttacker = lesMauvais
        }
    }
}
