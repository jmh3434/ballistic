//
//  GameScene.swift
//  ballistic
//
//  Created by James Hunt on 7/10/18.
//  Copyright © 2018 James Hunt. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private let kAnimalNodeName = "movable"
    //bitmasks
    let mainCategory:UInt32 = 0x1 << 0 //1
    let ballCategory:UInt32 = 0x1 << 1        //2
    //
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    
    var score = [Int]()
    //rotate
    let rotateRec = UIRotationGestureRecognizer()
    var theRotation:CGFloat = 0
    var offset:CGFloat = 0
    
    
    override func didMove(to view: SKView) {
        createSprites()
        //rotate
        rotateRec.addTarget(self, action: #selector(GameScene.rotatedView(_:)))
        self.view!.addGestureRecognizer(rotateRec)
        
        //
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        print(self.view?.bounds.height as Any)
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        
        let border  = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
        //bitmasks
        main.physicsBody?.categoryBitMask = mainCategory
        ball.physicsBody?.collisionBitMask = mainCategory
        //
    }
    func createSprites() {
        
        
    }
    //rotate
    @objc func rotatedView(_ sender:UIRotationGestureRecognizer){
        if (sender.state == .began){
            print("we began")
        }
        if (sender.state == .changed){
            print("we rotated")
            theRotation = CGFloat(sender.rotation) + self.offset  
            theRotation = theRotation * -1
            main.zRotation = theRotation
        }
        if (sender.state == .ended){
            print("we ended")
            self.offset = theRotation * -1
        }
    }
    //
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        case .player2:
            
            break
        }
        
        
        
        if ball.position.y <= main.position.y - 30 {
            addScore(playerWhoWon: enemy)
        }
        
    }

    
    func startGame() {
        score = [0,0]
        
        main.zRotation = 2
        //ball.physicsBody?.applyImpulse(CGVector(dx: 10 , dy: 10))
        
    }
    
    func addScore(playerWhoWon : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
       
        
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            

            
            
        }
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let name = touchedNode.name
            {
                if name == "main"
                {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.0))
                    main.run(SKAction.moveTo(y: location.y, duration: 0.0))
                }
                
            }
            
           
            
            
        }
    }
    
    }






