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
    private var square : SKSpriteNode?
    private var greensquare: SKSpriteNode?
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
        self.square = self.childNode(withName: "//redsquare") as? SKSpriteNode
        if let square = self.square {
            square.alpha = 0.0
            square.run(SKAction.fadeIn(withDuration: 2.0))
                //player.zRotation(32.4)
        }
        self.greensquare = self.childNode(withName: "//greensquare") as? SKSpriteNode
        
        
    }
    func didMove(to view: GameScene){
        let apple = SKSpriteNode(imageNamed: "Apple.png")
        apple.position = CGPoint(x: size.width/2, y: size.height/2)
            
        addChild(apple)
        let moveBottomLeft = SKAction.move(to: CGPoint(x: 100,y: 100), duration:2.0)
        apple.run(moveBottomLeft)
    }
    //let creates immutable variables -- var creates mutable variables.
    
    func touchDown(atPoint pos : CGPoint) {
        
        if let n = self.player?.copy() as! SKSpriteNode? {
            n.position = pos
            //n.strokeColor = SKColor.green
           // self.addChild(n)
            //class var mouseLocation : NSPoint {get}
            
            player?.position = pos // since pos is the pair of coordinates, it can be used to set coordinates of the SKNode 'player' in this instance
            //player?.position = CGPoint(x:200.6,y:310.4)
            //print(player?.anchorPoint)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
        if let n = self.player?.copy() as! SKSpriteNode? {
            n.position = pos
            //n.strokeColor = SKColor.blue
            //self.addChild(n)
            player?.position = pos
            //player?.position = CGPoint(x:pos.x+100,y:pos.y+50)
            square?.position = CGPoint(x:Double.random(in: -350..<350),y: Double.random(in: -350..<350))
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
            player?.position = pos
            
            //player?.position = CGPoint(x:0,y:0) //resets player position to 0,0
        }
        //if let g = self.greensquare?.copy() as! SKSpriteNode?{
        greensquare?.position = CGPoint(x:(greensquare?.position.x)!+50,y:(greensquare?.position.y)!)
        if((greensquare?.position.x)! > 350.0){
            greensquare?.position = CGPoint(x: -177.2, y:260.784)
        }
        //}
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
