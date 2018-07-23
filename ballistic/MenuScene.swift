import SpriteKit

class MenuScene: SKScene {
     var skView: SKView!
    var playButton = SKSpriteNode()
   
    
    override func didMove(to view: SKView) {
        playButton = self.childNode(withName: "play") as! SKSpriteNode
        
        playButton.position = CGPoint(x: frame.midX, y: frame.midY)
            
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == playButton {
                
//                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
//                    let scene:SKScene = GameScene(size: self.size)
//                    self.view?.presentScene(scene, transition: transition)
                
                let reveal = SKTransition.reveal(with: .down,
                                                 duration: 1)
                let newScene = GameScene(size: CGSize(width: 1024, height: 768))
                
                self.view?.presentScene(newScene, transition: reveal)
            }
        }
    }
}
