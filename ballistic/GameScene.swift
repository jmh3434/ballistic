//
//  GameScene.swift
//  ballistic
//
//  Created by James Hunt on 7/10/18.
//  Copyright © 2018 James Hunt. All rights reserved.
//

import SpriteKit
import Foundation
import GameplayKit
import Darwin
import UIKit


protocol GameSceneDelegate {
    func gameOver()
}

class GameScene: SKScene,SKPhysicsContactDelegate {
    private let kAnimalNodeName = "movable"
    var gameSceneDelegate: GameSceneDelegate?
    
    //bitmasks
    
//    let ballCategory:UInt32   = 0x00000001
//    let goalCategory:UInt32 = 0x00000002
    
    
    
    
    let plank1Category:UInt32 = 0x00000004
    let plank2Category:UInt32 = 0x00000005
    let mainCategory:UInt32   = 0x00000006
    let enemyCategory:UInt32  = 0x00000007
     var skView: SKView!
    var menuScene: MenuScene!
    
    var lastTouchedNode = ""
    
    
    
    var location = CGPoint.zero
    
    var touchedSprite:Bool = false
    var gameIsBeingPlayed = false
    var turnPressed = false
    var turn2Pressed = false
    //
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var plank1 = SKSpriteNode()
    var plank2 = SKSpriteNode()
    var finish = SKSpriteNode()
    var stop = SKSpriteNode()
    var goal = SKSpriteNode()
    var turn = SKSpriteNode()
    var turn2 = SKSpriteNode()
    var back = SKSpriteNode()
    
    let winner = SKLabelNode()
    
    var touchingNode = String()
    var touched = true
    
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    
    
    var score = [Int]()
    //rotate
    let rotateRec = UIRotationGestureRecognizer()
    var theRotation:CGFloat = 0
    var offset:CGFloat = 0
    
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    
    
    override func didMove(to view: SKView) {
       
        
        
        
        
        print("hello1")
        self.physicsWorld.contactDelegate = self
        
        turn.isHidden = true
        turn2.isHidden = true
        
        // rotation
        

        
        winner.fontSize = 65
        winner.fontColor = SKColor.green
        winner.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(winner)
        
        self.view?.isMultipleTouchEnabled = false
        
        //rotate
        //rotateRec.addTarget(self, action: #selector(GameScene.rotatedView(_:)))
        //self.view!.addGestureRecognizer(rotateRec)
        
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
        turn = self.childNode(withName: "turn") as! SKSpriteNode
        turn2 = self.childNode(withName: "turn2") as! SKSpriteNode
        back = self.childNode(withName: "back") as! SKSpriteNode

        
        
        
        let border  = SKPhysicsBody(edgeLoopFrom: self.frame)
        
       // border.friction = 0
       // border.restitution = 1
        
       // self.physicsBody = border
        
        score = [0,0]
        
        main.zRotation = 0
        //bitmasks
        turn.position = CGPoint(x:main.position.x+120, y:main.position.y)
        
        
        
    }
   
    //rotate
    /*
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
    */
    //
    override func update(_ currentTime: TimeInterval) {
       // turn.position = CGPoint(x:main.position.x+120, y:main.position.y)
        turn2.position = CGPoint(x:enemy.position.x+120, y:enemy.position.y)
    
    if (touchedSprite) {
        moveNodeToLocation()
    }
     if ball.position.y <= -160 {
        resetBlocks()
     }
        if lastTouchedNode == "main" {
            turn.isHidden = false
        }else{
            turn.isHidden = true
        }
        if lastTouchedNode == "enemy" {
            turn2.isHidden = false
        }else{
            turn2.isHidden = true
        }
    
        

    }
    func didBegin(_ contact: SKPhysicsContact) {
        let contactA:SKPhysicsBody = contact.bodyA
        let contactB:SKPhysicsBody = contact.bodyB
        
        if contactA.categoryBitMask == 2 && contactB.node?.name == "ball" {
            self.winner.text = "You Win!"
            level1conquered = true
        }
    }
    func moveNodeToLocation() {
        
        if touchingNode == "main" {
           
            
            
            var dx = location.x - main.position.x
            var dy = location.y - main.position.y
            // How fast to move the node. Adjust this as needed
            let speed:CGFloat = 0.25
            // Scale vector
            dx = dx * speed
            dy = dy * speed
            
            main.position = CGPoint(x:main.position.x+dx, y:main.position.y+dy)
            
            turn.position = CGPoint(x:turn.position.x+dx, y:turn.position.y+dy)
            //turn.position = CGPoint(x: main.position.x+120, y: main.position.y)
        
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
        
            turn.isHidden = true
            turn2.isHidden = true
            lastTouchedNode = ""
            main.physicsBody?.isDynamic = false
            enemy.physicsBody?.isDynamic = false
            ball.physicsBody?.isDynamic = false
        
        
            gameIsBeingPlayed = false
            self.winner.text = ""

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
            turn.position = CGPoint(x:main.position.x+120, y:main.position.y)
            turn.zRotation = -3.907
        
    }
    func CGVectorMake(point1:CGFloat,point2:CGFloat) -> CGVector{
        var newPoint1 = CGVector(dx:point1,dy:point2)
        
        return (newPoint1)
    }

    
    func startGame() {
        main.physicsBody?.categoryBitMask = mainCategory
        enemy.physicsBody?.categoryBitMask = enemyCategory
        plank1.physicsBody?.categoryBitMask = plank1Category
        plank2.physicsBody?.categoryBitMask = plank2Category
        
        
        ball.physicsBody?.collisionBitMask = mainCategory
        ball.physicsBody?.collisionBitMask = enemyCategory
        ball.physicsBody?.collisionBitMask = plank1Category
        ball.physicsBody?.collisionBitMask = plank2Category
        
        
        main.physicsBody?.collisionBitMask = plank1Category
        enemy.physicsBody?.collisionBitMask = plank2Category
        
        main.physicsBody?.collisionBitMask = plank2Category
        enemy.physicsBody?.collisionBitMask = plank1Category
        
        //ball.physicsBody?.applyImpulse(CGVector(dx: 10 , dy: 10))
        
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
                     lastTouchedNode = "main"
                    
                } else if name == "enemy" {
                    touchingNode = "enemy"
                     lastTouchedNode = "enemy"
                    
                } else if name == "finish" {
                    startGame()
                    main.physicsBody?.isDynamic = true
                    enemy.physicsBody?.isDynamic = true
                    ball.physicsBody?.isDynamic = true
                    
                    gameIsBeingPlayed = true
                    touchingNode = ""
                     lastTouchedNode = "finish"
                    if touched {
                        
                        
                        physicsWorld.gravity = CGVector(dx: 0, dy: -3.0)
                        

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
                     lastTouchedNode = "stop"
                } else if name == "turn" {
                    
                } else if name == "back" {
                    
                    
                    
                   // let currentViewController:UIViewController=UIApplication.shared.keyWindow!.rootViewController!
                    ////let vc = GameViewController()
                   // currentViewController.present(vc, animated: true, completion: nil)
                    
                    //self.view?.window?.rootViewController?.present(vc, animated: true, completion: nil)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    let vc = storyboard.instantiateViewController(withIdentifier: "levels")
                    
                    vc.view.frame = (self.view?.frame)!
                    
                    vc.view.layoutIfNeeded()
                    
                    
                    
                    UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:
                        
                        {
                            
                            self.view?.window?.rootViewController = vc
                            
                    }, completion: { completed in
                        
                        
                        
                    })
                    
                    
                    
                




                  
                } else {
                    touchingNode = ""
                }
                
            }
        }
    }
    var anglep = CGFloat()
    var once = true
    
    var oldLocationX = CGFloat()
    var oldLocationY = CGFloat()
    var angle = CGFloat()
    var oldZ = CGFloat()
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //var james = true
       
        if !gameIsBeingPlayed {
        touchedSprite = true
        for touch in touches {
            location = touch.location(in: self)
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if let name = touchedNode.name {
                if name == "turn" {
                
                touchingNode = "turn"
                }else if name == "turn2" {
                    
                    touchingNode = "turn2"
                }
            }
            

                if touchingNode == "turn" {
        
                    
                    let angle = atan2(location.x - main.position.x , location.y -
                        main.position.y)
                    
                    
                    
                    main.zRotation = -((angle - CGFloat((Double.pi/2))))
                    
            
                    
//                    if main.zRotation > 0 &&  main.zRotation < 1.57079632679 {
//                         turn.position = CGPoint(x:main.frame.maxX+20, y:main.frame.maxY)
//                    }else if main.zRotation < 0 && main.zRotation > -1.57079632679{
//                        turn.position = CGPoint(x:main.frame.maxX+20, y:main.frame.minY)
//                    }else if main.zRotation < 3.14 &&  main.zRotation > 1.57079632679{
//                         turn.position = CGPoint(x:main.frame.minX, y:main.frame.maxY+20)
//                    }else {
//                        turn.position = CGPoint(x:main.frame.minX, y:main.frame.minY-20)
//                    }
                    
                    //turn.position =
                    var sinus = (sinf(Float(main.zRotation))*125)
                    var cosin = (cosf(Float(main.zRotation))*125)
                    
                    var sine = main.frame.midY + CGFloat(sinus)
                    var cosine = main.frame.midX + CGFloat(cosin)
                    
                    
                    

                    turn.position = CGPoint(x: cosine, y: sine)
                    
                    
                    
                    turn.zRotation = -0.71-((angle + CGFloat((Double.pi/2))))
                    print(-((angle + CGFloat((Double.pi/2)))))
                    print(turn.zRotation)
                    
                    
                    
                    
                    
                    
               
                 

                    
                    
                    
                    
                    
                    
                    
                }else if touchingNode == "turn2" {
                    
                    
                    let angle = atan2(location.x - enemy.position.x , location.y -
                        enemy.position.y)
                    enemy.zRotation = -((angle - CGFloat((Double.pi/2))))
                }
                
            
            
           
            
        }
        }
        

    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchedSprite = false
        touchingNode = ""
    }
    
}






