//
//  GameViewController.swift
//  Pong2
//
//  Created by Jared Davidson on 10/11/16.
//  Copyright © 2016 Archetapp. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


var currentGameType = gameLevel.one


class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            print("current game type: ", currentGameType)
            
            if currentGameType == .one {
               let scene = SKScene(fileNamed: "GameScene")
                // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                
                scene?.size = view.bounds.size
                
                // Present the scene
                view.presentScene(scene)
            }else if currentGameType == .two {
                let scene = SKScene(fileNamed: "GameScene2")
                // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                
                scene?.size = view.bounds.size
                
                // Present the scene
                view.presentScene(scene)
            }
            
            
            
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
