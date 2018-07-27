//
//  MenuVC.swift
//  Pong2
//
//  Created by Jared Davidson on 1/9/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import Foundation
import UIKit

var level1conquered = false
var level2conquered = false
var level3conquered = false
var level4conquered = false

enum gameLevel {
    case one
    case two
    case three
    case four
}

class MenuVC : UIViewController {
    
    @IBOutlet var level1: UIButton!
    
    @IBOutlet var level2: UIButton!
    @IBOutlet var level3: UIButton!
    @IBOutlet var level4: UIButton!
    @IBAction func one(_ sender: Any) {
        print("11")
        moveToGame(game: .one)
    }
    
    @IBAction func two(_ sender: Any) {
        moveToGame(game: .two)
    }
    @IBAction func three(_ sender: Any) {
        moveToGame(game: .three)
        
    }
    @IBAction func four(_ sender: Any) {
        moveToGame(game: .four)
    }
    override func viewDidLoad() {
        if level1conquered {
            level1.backgroundColor = UIColor.white
        }
        if level2conquered {
            level2.backgroundColor = UIColor.white
        }
        if level3conquered {
            level3.backgroundColor = UIColor.white
        }
        if level4conquered {
            level4.backgroundColor = UIColor.white
        }
    }
    func moveToGame(game : gameLevel) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        
        self.present(gameVC, animated: true, completion: nil)
        
        print("12")
    }
}
