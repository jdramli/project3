//
//  GameScene.swift
//  project3 Xcode
//
//  Created by Joseph Daniel Ramli on 9/23/19.
//  Copyright © 2019 Joseph Daniel Ramli. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var player : SKSpriteNode?
    private var spinnyNode : SKShapeNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.player = self.childNode(withName: "//player") as? SKSpriteNode
        if let player = self.player {
            player.alpha = 0.0
            player.run(SKAction.fadeIn(withDuration: 2.0))
                //player.zRotation(32.4)
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    //let creates immutable variables -- var creates mutable variables.
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.player?.copy() as! SKSpriteNode? {
            n.position = pos
            //n.strokeColor = SKColor.green
            self.addChild(n)
            //class var mouseLocation : NSPoint {get}
            
            player?.position = pos // since pos is the pair of coordinates, it can be used to set coordinates of the SKNode 'player' in this instance
            //player?.position = CGPoint(x:200.6,y:310.4)
            //print(player?.anchorPoint)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
            player?.position = pos
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.player?.copy() as! SKSpriteNode? {
            n.position = pos
            //n.strokeColor = SKColor.red
            //self.addChild(n)
            //The next 3 lines will move the 'player' to a random location when trackpad click is RELEASED
            //let rand_x = Double.random(in: -350..<350)
            //let rand_y = Double.random(in:-750..<750)
            //player?.position = CGPoint(x:rand_x,y:rand_y)
            //player?.position = pos
            
            //player?.position = CGPoint(x:0,y:0) //resets player position to 0,0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let player = self.player {
//            player.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
        
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
