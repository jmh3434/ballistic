//
//  MenuVC.swift
//  Pong2
//
//  Created by Jared Davidson on 1/9/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import Foundation
import UIKit

enum gameLevel {
    case one
    case two
    case three
    case four
}

class MenuVC : UIViewController {
    
    
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
    
    func moveToGame(game : gameLevel) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        
        self.present(gameVC, animated: true, completion: nil)
        
        print("12")
    }
}
