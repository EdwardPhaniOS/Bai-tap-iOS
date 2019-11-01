//
//  CardBrain.swift
//  GameBaiCao
//
//  Created by iMac_VTCA on 10/23/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

struct CardBrain {
    var fullCard = [Card]()
    var userCard = [Card]()
    var enemyCard = [Card]()
   
    init() {
        let array = ["b", "ch", "c", "r"]
        
        for element in array {
            for i in 1...13 {
                
                let cardName = "\(i)_\(element)"
                let image = UIImage(named: cardName)
                
                var score = 0
                if i >= 10 {
                    score = 10
                } else {
                    score = i
                }
                
                let card = Card(name: cardName, point: score, image: image)
                
                fullCard.append(card)
            }
        }
    }
    
    mutating func getRandomCardForUser() {
        let randomInt = Int.random(in: 0..<fullCard.count)
        let card = fullCard[randomInt]
        fullCard.remove(at: randomInt)
        
        self.userCard.append(card)
    }
    
    mutating func getRandomCardForEnemy() {
           let randomInt = Int.random(in: 0..<fullCard.count)
           let card = fullCard[randomInt]
           fullCard.remove(at: randomInt)
           
           self.enemyCard.append(card)
    }
    
    func getUserScore() -> Int {
        var totalScore = 0
        
        for card in userCard {
            totalScore += card.point
        }
        
        let resultString = "\(totalScore)"
        let digits = resultString.compactMap{ $0.wholeNumberValue }
    
        return digits.last ?? 0
    }
    
    func getEnemyScore() -> Int {
        var totalScore = 0
        
        for card in enemyCard {
            totalScore += card.point
        }
        
        let resultString = "\(totalScore)"
        let digits = resultString.compactMap{ $0.wholeNumberValue }
    
        return digits.last ?? 0
    }
    
    mutating func restartGame() {
        fullCard.removeAll()
        userCard.removeAll()
        enemyCard.removeAll()
        
        self.fullCard = CardBrain().fullCard
    }
}
