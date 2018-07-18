//
//  GameScene.swift
//  ballistic
//
//  Created by James Hunt on 7/10/18.
//  Copyright © 2018 James Hunt. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    private let kAnimalNodeName = "movable"
    //bitmasks
    let mainCategory:UInt32   = 0x00000001
    let ballCategory:UInt32   = 0x00000002
    let enemyCategory:UInt32  = 0x00000003
    let plank1Category:UInt32 = 0x00000004
    let plank2Category:UInt32 = 0x00000005
    let goalCategory:UInt32   = 0x00000006
    var location = CGPoint.zero
    
    var touchedSprite:Bool = false
    
    //
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var plank1 = SKSpriteNode()
    var plank2 = SKSpriteNode()
    var finish = SKSpriteNode()
    var stop = SKSpriteNode()
    var goal = SKSpriteNode()
    
    
    var touchingNode = String()
    var touched = true
    
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    
    var score = [Int]()
    //rotate
    let rotateRec = UIRotationGestureRecognizer()
    var theRotation:CGFloat = 0
    var offset:CGFloat = 0
    
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self


        
        
        self.view?.isMultipleTouchEnabled = false
        createSprites()
        setGravity()
        //rotate
        rotateRec.addTarget(self, action: #selector(GameScene.rotatedView(_:)))
        self.view!.addGestureRecognizer(rotateRec)
        
        let vector =  CGVector(dx: 0, dy: 0)
        //
        self.physicsWorld.gravity = vector
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        ball.position.y = (self.frame.height / 2) - 80
        ball.position.x = (self.frame.width / 4)
        ball.physicsBody?.pinned = true
        
        
        
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        enemy.position.y = (self.frame.height / 2) - 40
        enemy.position.x = (self.frame.width / 4) - 390
        main.position.y = (self.frame.height / 2) - 40
        main.position.x = (self.frame.width / 3) - 200
        
        plank1 = self.childNode(withName: "plank1") as! SKSpriteNode
        plank2 = self.childNode(withName: "plank2") as! SKSpriteNode
        finish = self.childNode(withName: "finish") as! SKSpriteNode
        stop = self.childNode(withName: "stop") as! SKSpriteNode
        goal = self.childNode(withName: "goal") as! SKSpriteNode
        
        
        
        let border  = SKPhysicsBody(edgeLoopFrom: self.frame)
        
       // border.friction = 0
       // border.restitution = 1
        
       // self.physicsBody = border
        
        startGame()
        //bitmasks
        main.physicsBody?.categoryBitMask = mainCategory
        enemy.physicsBody?.categoryBitMask = enemyCategory
        plank1.physicsBody?.categoryBitMask = plank1Category
        plank2.physicsBody?.categoryBitMask = plank2Category
        goal.physicsBody?.categoryBitMask = goalCategory
        
        ball.physicsBody?.collisionBitMask = mainCategory
        ball.physicsBody?.collisionBitMask = enemyCategory
        ball.physicsBody?.collisionBitMask = plank1Category
        ball.physicsBody?.collisionBitMask = plank2Category
        
        main.physicsBody?.collisionBitMask = plank1Category
        enemy.physicsBody?.collisionBitMask = plank2Category
        
        
        
        let mask1 = 0x000000FF
        let mask2 = 0x000000F0
        
        let result = mask1 & mask2 // result = 0x000000F0
        
        
        //
    }
    
    func setGravity(){
        
        //ball.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        //ball.physicsBody!.affectedByGravity = false

    
    }
    func createSprites() {
        
        
    }
    //rotate
    
    @objc func rotatedView(_ sender:UIRotationGestureRecognizer){
        touchedSprite = false
        
        
        if (sender.state == .began){
            
        }
        if (sender.state == .changed){
            
            theRotation = CGFloat(sender.rotation) + self.offset
            theRotation = theRotation * -1
            if touchingNode == "main" {
                main.zRotation = theRotation
            }else if touchingNode == "enemy" {
                enemy.zRotation = theRotation
            }


        }
        if (sender.state == .ended){
            
            self.offset = theRotation * -1
        }
    }
    //
    override func update(_ currentTime: TimeInterval) {
    
    if (touchedSprite) {
        moveNodeToLocation()
    }
     if ball.position.y <= -160 {
        resetBlocks()
     }
    
        

    }
    func didBeginContact(contact: SKPhysicsContact) {
        print("contact")
        if contact.bodyA.node == goal || contact.bodyB.node == goal {
             print("contact2 ")
        }
    }
    func moveNodeToLocation() {
        if touchingNode == "main" {
            
            // Compute vector components in direction of the touch
            var dx = location.x - main.position.x
            var dy = location.y - main.position.y
            // How fast to move the node. Adjust this as needed
            let speed:CGFloat = 0.25
            // Scale vector
            dx = dx * speed
            dy = dy * speed
            main.position = CGPoint(x:main.position.x+dx, y:main.position.y+dy)
            
            
        }else if touchingNode == "enemy" {
            // Compute vector components in direction of the touch
            var dx = location.x - enemy.position.x
            var dy = location.y - enemy.position.y
            // How fast to move the node. Adjust this as needed
            let speed:CGFloat = 0.25
            // Scale vector
            dx = dx * speed
            dy = dy * speed
            enemy.position = CGPoint(x:enemy.position.x+dx, y:enemy.position.y+dy)
        }
        
        
    }
    func resetBlocks() {
       
            //addScore(playerWhoWon: enemy)
            //ball.physicsBody!.affectedByGravity = false
            ball.physicsBody?.affectedByGravity = false
            main.physicsBody?.affectedByGravity = false
            enemy.physicsBody?.affectedByGravity = false
            
            physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0) // no gravity
            
            enemy.position.y = (self.frame.height / 2) - 40
            enemy.position.x = (self.frame.width / 4) - 390
            main.position.y = (self.frame.height / 2) - 40
            main.position.x = (self.frame.width / 3) - 200
            
            ball.position.y = (self.frame.height / 2) - 80
            ball.position.x = (self.frame.width / 4)
            
            ball.physicsBody?.pinned = true
            main.physicsBody?.velocity = CGVectorMake(point1: 0.0, point2: 0.0)
            enemy.physicsBody?.velocity = CGVectorMake(point1: 0.0, point2: 0.0)
            main.physicsBody?.angularVelocity = 0
            enemy.physicsBody?.angularVelocity = 0
            main.zRotation = 0
            enemy.zRotation = 0
            
            
            
        
            touched = true
            
        
    }
    func CGVectorMake(point1:CGFloat,point2:CGFloat) -> CGVector{
        var newPoint1 = CGVector(dx:point1,dy:point2)
        
        return (newPoint1)
    }

    
    func startGame() {
        score = [0,0]
        
         main.zRotation = 0
        //ball.physicsBody?.applyImpulse(CGVector(dx: 10 , dy: 10))
        
    }
    
    func addScore(playerWhoWon : SKSpriteNode){
        
      //  ball.position = CGPoint(x: 0, y: 0)
        //ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
       
        
        
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        

        
        
        
        touchedSprite = true
        for touch in touches {
            location = touch.location(in:self)
            
           
            
            
            
        }
        
        
        for touch in touches {
            
            
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let name = touchedNode.name
            {
                if name == "main" {
                    touchingNode = "main"
                    
                } else if name == "enemy" {
                    touchingNode = "enemy"
                    
                } else if name == "finish" {
                    touchingNode = ""
                    let vector =  CGVector(dx: 0, dy: -1)
                    
                    //
                    if touched {

                        //self.physicsWorld.gravity = vector
                        physicsWorld.gravity = CGVector(dx: 0, dy: -3.8)
                        //ball.physicsBody!.affectedByGravity = true

                        ball.physicsBody?.affectedByGravity = true
                        main.physicsBody?.affectedByGravity = true
                        enemy.physicsBody?.affectedByGravity = true

                        ball.physicsBody?.pinned = false
                        main.physicsBody?.pinned = false
                        enemy.physicsBody?.pinned = false

                        

                        touched = false
                    }
   
                } else if name == "stop" {
                    resetBlocks()
                    touchingNode = ""
                } else {
                    touchingNode = ""
                }
                
            }
            
            
            
            
        }

        
        

        
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchedSprite = true
        for touch in touches {
            location = touch.location(in: self)
        }
        
//        for touch in touches {
//            let location = touch.location(in: self)
//            let positionInScene = touch.location(in: self)
//            let touchedNode = self.atPoint(positionInScene)
//
//            if let name = touchedNode.name
//            {
//                if name == "main"
//                {
//                    touchingNode = "main"
//                    main.position.x = (location.x)
//                    main.position.y = (location.y)
////                    main.run(SKAction.moveTo(x: location.x, duration: 0.0))
////                    main.run(SKAction.moveTo(y: location.y, duration: 0.0))
//                }
//                if name == "enemy"
//                {
//                    touchingNode = "enemy"
//                    enemy.position.x = (location.x)
//                    enemy.position.y = (location.y)
////                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.0))
////                    enemy.run(SKAction.moveTo(y: location.y, duration: 0.0))
//                }
//
//                if name == "finish"
//                {
//                    //let vector =  CGVector(dx: 0, dy: -1)
//
//                    //
//                    if touched {
//
//                        //self.physicsWorld.gravity = vector
//                        physicsWorld.gravity = CGVector(dx: 0, dy: -3.8)
//                        //ball.physicsBody!.affectedByGravity = true
//
//                        ball.physicsBody?.affectedByGravity = true
//                        main.physicsBody?.affectedByGravity = true
//                        enemy.physicsBody?.affectedByGravity = true
//
//                        ball.physicsBody?.pinned = false
//                        main.physicsBody?.pinned = false
//                        enemy.physicsBody?.pinned = false
//
//                        print("dr phil ")
//
//                        touched = false
//
//
//                    }
//
//
//
//
//
//
//                }
//                if name == "stop"{
//                    resetBlocks()
//                }
//
//            }
//
//
//
//
//        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchedSprite = false
        touchingNode = ""
    }
    
    }






