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
    let mainCategory:UInt32   = 0x00000001
    let ballCategory:UInt32   = 0x00000002
    let enemyCategory:UInt32  = 0x00000003
    let plank1Category:UInt32 = 0x00000004
    let plank2Category:UInt32 = 0x00000005
    
    //
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var plank1 = SKSpriteNode()
    var plank2 = SKSpriteNode()
    var finish = SKSpriteNode()
    var touchingNode = String()
    
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
        
        let vector =  CGVector(dx: 0, dy: 0)
        //
        self.physicsWorld.gravity = vector
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        print(self.view?.bounds.height as Any)
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        
        plank1 = self.childNode(withName: "plank1") as! SKSpriteNode
        plank2 = self.childNode(withName: "plank2") as! SKSpriteNode
        finish = self.childNode(withName: "finish") as! SKSpriteNode
        
        let border  = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
        //bitmasks
        main.physicsBody?.categoryBitMask = mainCategory
        enemy.physicsBody?.categoryBitMask = enemyCategory
        plank1.physicsBody?.categoryBitMask = plank1Category
        plank2.physicsBody?.categoryBitMask = plank2Category
        
        ball.physicsBody?.collisionBitMask = mainCategory
        ball.physicsBody?.collisionBitMask = enemyCategory
        ball.physicsBody?.collisionBitMask = plank1Category
        ball.physicsBody?.collisionBitMask = plank2Category
        
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
            if touchingNode == "main" {
                main.zRotation = theRotation
            }else if touchingNode == "enemy" {
                enemy.zRotation = theRotation
            }
            
            
        }
        if (sender.state == .ended){
            print("we ended")
            self.offset = theRotation * -1
        }
    }
    //
    override func update(_ currentTime: TimeInterval) {
        
        
        
        if ball.position.y <= main.position.y - 30 {
            addScore(playerWhoWon: enemy)
        }
        
    }

    
    func startGame() {
        score = [0,0]
        
         main.zRotation = 0
        //ball.physicsBody?.applyImpulse(CGVector(dx: 10 , dy: 10))
        
    }
    
    func addScore(playerWhoWon : SKSpriteNode){
        
      //  ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
       
        
        
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
                    touchingNode = "main"
                    main.run(SKAction.moveTo(x: location.x, duration: 0.0))
                    main.run(SKAction.moveTo(y: location.y, duration: 0.0))
                }
                if name == "enemy"
                {
                    touchingNode = "enemy"
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.0))
                    enemy.run(SKAction.moveTo(y: location.y, duration: 0.0))
                }
                if name == "finish"
                {
                    let vector =  CGVector(dx: 0, dy: -1)
                    //
                    self.physicsWorld.gravity = vector
                    print("touched")
                    
                }
                
            }
            
           
            
            
        }
    }
    
    }






