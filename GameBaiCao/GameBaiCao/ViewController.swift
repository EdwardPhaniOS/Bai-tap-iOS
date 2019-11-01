//
//  ViewController.swift
//  GameBaiCao
//
//  Created by iMac_VTCA on 10/23/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

//Can them Animation va Clean code

import UIKit

class ViewController: UIViewController {
    
    var cardBrain = CardBrain()
    var counter = 0
    var timer = Timer()
    var yourScore = 0
    var enemyScore = 0
    var playAgain = false
    let image = UIImage(named: "up")
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var yourCard1: UIImageView!
    @IBOutlet weak var yourCard2: UIImageView!
    @IBOutlet weak var yourCard3: UIImageView!
    
    @IBOutlet weak var enemyCard1: UIImageView!
    @IBOutlet weak var enemyCard2: UIImageView!
    @IBOutlet weak var enemyCard3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func startPressed(_ sender: UIButton) {
        
        timer.invalidate()
        
        if playAgain == true {
            cardBrain.restartGame()
            restartUI()
            counter = 0
         
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.getACard), userInfo: nil, repeats: true)
    }
    
    @objc func getACard() {
        
    
        if counter < 6 {
            if counter % 2 == 0 {
                cardBrain.getRandomCardForUser()
            } else {
                cardBrain.getRandomCardForEnemy()
            }
            
            counter += 1
            
            updateUI()
        } else {
            timer.invalidate()
            showResult()
        }
        
        playAgain = true
        startButton.setTitle("Chơi lại", for: .normal)
    }
    
    func updateUI() {
        
            switch counter {
            case 1:
                yourCard1.image = cardBrain.userCard.first?.image
            case 2:
                enemyCard1.image = cardBrain.enemyCard.first?.image
            case 3:
                yourCard2.image = cardBrain.userCard[1].image
            case 4:
                enemyCard2.image = cardBrain.enemyCard[1].image
            case 5:
                yourCard3.image = cardBrain.userCard[2].image
            case 6:
                enemyCard3.image = cardBrain.enemyCard[2].image
                
            default:
                print("Error")
            }
    }
    
    func restartUI() {
        yourCard1.image = image
        yourCard2.image = image
        yourCard3.image = image

        enemyCard1.image = image
        enemyCard2.image = image
        enemyCard3.image = image
    }
    
    func showResult() {
        let userScore = cardBrain.getUserScore()
        let enemyScore = cardBrain.getEnemyScore()
        
        if userScore > enemyScore {
            showAlert(title: "You won")
        } else if userScore < enemyScore {
            showAlert(title: "You lost")
        } else {
            showAlert(title: "You and your enemy have a same score")
        }
        
    }
    
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

