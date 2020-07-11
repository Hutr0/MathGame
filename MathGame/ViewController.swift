//
//  ViewController.swift
//  MathGame
//
//  Created by Леонид Лукашевич on 06.07.2020.
//  Copyright © 2020 Hutr0. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var randomText: UILabel!
    @IBOutlet weak var userText: UILabel!
    @IBOutlet weak var userScore: UILabel!
    var text: String = ""
    var scr = score()
    var num = numbers()
    
    struct score {
        var score: UInt32
        
        init() {
            self.score = 1
        }
        
        mutating func win() -> String {
            
            self.score += 1
            return String(self.score - 1)
        }
        
        mutating func loss() -> String {
            
            self.score = 1
            return String(self.score - 1)
        }
    }
    
    struct numbers {
        var first: UInt32
        var second: UInt32
        
        init() {
            self.first = 0
            self.second = 0
        }
        
        mutating func setNum(_ score: UInt32) -> String {
            
            print("New Feature YYY")
            self.first = arc4random_uniform(score * 2) + score / 2
            self.second = arc4random_uniform(score * 2) + score / 2
            return "\(self.first) + \(self.second)"
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userScore.text = String(scr.score - 1)
        randomText.text = num.setNum(scr.score)
    }
    
    @IBAction func setNumberString(_ sender: UIButton) {
        
        text += sender.titleLabel!.text!
        userText.text = text
    }
    @IBAction func deleteLastNumberString() {
        
        if !text.isEmpty {
            text.removeLast()
            userText.text = text
        }
    }
    @IBAction func verify() {
        
        if (num.first + num.second) == UInt32(text) {
            if scr.score == 10 {
                
                let alertController = UIAlertController(title: "Юху!",
                                                        message: "Ваш счёт превысил 10 очков, поздравляю!",
                                                        preferredStyle: UIAlertController.Style.alert
                )
                
                alertController.addAction(UIAlertAction(title: "Закрыть",
                                                        style: UIAlertAction.Style.default,
                                                        handler: nil))
                
                self.present(alertController,
                    animated: true,
                    completion: nil)
                }
            userText.text = "Верный ответ!"
            userScore.text = scr.win()
            randomText.text = num.setNum(scr.score)
        } else {
            userText.text = "Неверный ответ!"
            userScore.text = scr.loss()
            randomText.text = num.setNum(scr.score)
        }
        text = ""
    }
}
