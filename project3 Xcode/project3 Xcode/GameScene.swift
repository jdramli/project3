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
    private var pspeed = 40.0
    private var moves = 0
    private var redsquare : SKSpriteNode?
    private var redsquare2 : SKSpriteNode?
    private var redsquare3 : SKSpriteNode?
    private var greensquare: SKSpriteNode?
    private var yellowsquare: SKSpriteNode?
    private var yellowsquare1: SKSpriteNode?
    private var yellowsquare2: SKSpriteNode?
    
    private var winlabel: SKLabelNode?
    
    private var testtimer: SKLabelNode? //This ended up being the "number of moves" node
    private var time : Timer?
    
    private var up: SKSpriteNode?
    private var down: SKSpriteNode?
    private var left: SKSpriteNode?
    private var right: SKSpriteNode?
    
    private var randomize: SKSpriteNode?
    private var reset: SKSpriteNode?
    //private var spinnyNode : SKShapeNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        self.randomize = self.childNode(withName: "//randomize") as? SKSpriteNode
        self.reset = self.childNode(withName: "//reset") as? SKSpriteNode
         
        self.testtimer = self.childNode(withName: "//timer") as? SKLabelNode
        testtimer?.position = CGPoint(x:220,y:489)
        testtimer?.color = .brown
        time?.fire()
        print ("statement after call to time.fire()")
        //testtimer?.text = time?.fireDate.description
        
        // store nodes for winlabel and player
        self.winlabel = self.childNode(withName: "//contactlabel") as? SKLabelNode
        self.player = self.childNode(withName: "//player") as? SKSpriteNode
        //store nodes for directional keys
        self.up = self.childNode(withName: "//up") as? SKSpriteNode
        self.down = self.childNode(withName: "//down") as? SKSpriteNode
        self.left = self.childNode(withName: "//left") as? SKSpriteNode
        self.right = self.childNode(withName: "//right") as? SKSpriteNode
        
        self.redsquare = self.childNode(withName: "//redsquare") as? SKSpriteNode
        self.redsquare2 = self.childNode(withName: "//redsquare2") as? SKSpriteNode
        self.redsquare3 = self.childNode(withName: "//redsquare3") as? SKSpriteNode
       
        self.greensquare = self.childNode(withName: "//greensquare") as? SKSpriteNode
        self.yellowsquare = self.childNode(withName: "//yellowsquare")as? SKSpriteNode
        self.yellowsquare1 = self.childNode(withName: "//yellowsquare1")as? SKSpriteNode
        self.yellowsquare2 = self.childNode(withName: "//yellowsquare2")as? SKSpriteNode
        
        player?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:98, height:98))
        redsquare?.physicsBody = SKPhysicsBody(circleOfRadius: 29) //kept this as a circle for fun physics interactions
        redsquare2?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:58, height:58))
        redsquare3?.physicsBody = SKPhysicsBody(circleOfRadius: 29)
        //redsquare?.physicsBody?.mass = redsquare!.physicsBody!.mass*100
        //redsquare2?.physicsBody?.mass = redsquare2!.physicsBody!.mass*100
        //redsquare3?.physicsBody?.mass = redsquare3!.physicsBody!.mass*100
        
        //yellowsquare?.physicsBody = SKPhysicsBody(circleOfRadius: 29) //kept as circle for funny physics behavior
        yellowsquare?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:58, height:58))
        yellowsquare?.physicsBody?.mass = yellowsquare!.physicsBody!.mass*50
        //yellowsquare1?.physicsBody = SKPhysicsBody(circleOfRadius: 29) //kept as circle for funny physics behavior
        yellowsquare1?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:58, height:58)) //kept as circle for funny physics behavior
        yellowsquare1?.physicsBody?.mass = yellowsquare1!.physicsBody!.mass*50
        //yellowsquare2?.physicsBody = SKPhysicsBody(circleOfRadius: 29) //kept as circle for funny physics behavior
        yellowsquare2?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:58, height:58)) //kept as circle for funny physics behavior
        yellowsquare2?.physicsBody?.mass = yellowsquare2!.physicsBody!.mass*50
        greensquare?.physicsBody? = SKPhysicsBody(rectangleOf: CGSize(width:58, height:58))
        
        player?.physicsBody?.affectedByGravity = false
        redsquare?.physicsBody?.affectedByGravity = false
        redsquare2?.physicsBody?.affectedByGravity = false
        redsquare3?.physicsBody?.affectedByGravity = false
        yellowsquare?.physicsBody?.affectedByGravity = false
        yellowsquare1?.physicsBody?.affectedByGravity = false
        yellowsquare2?.physicsBody?.affectedByGravity = false
        redsquare?.physicsBody?.collisionBitMask = 0b0001
        redsquare2?.physicsBody?.collisionBitMask = 0b0001
        redsquare3?.physicsBody?.collisionBitMask = 0b0001
        yellowsquare?.physicsBody?.collisionBitMask = 0b0001
        yellowsquare1?.physicsBody?.collisionBitMask = 0b0001
        yellowsquare2?.physicsBody?.collisionBitMask = 0b0001
        greensquare?.physicsBody?.collisionBitMask = 0b0001
        player?.physicsBody?.collisionBitMask = 0b0001
        
        //yellowsquare1 = yellowsquare!.copy() as? SKSpriteNode
        greensquare?.physicsBody?.affectedByGravity = false
        //Set friction and mass
        player?.physicsBody?.friction = CGFloat(0.7)
        greensquare?.physicsBody?.friction = CGFloat(0.7)
        
        //greensquare?.physicsBody?.contactTestBitMask = 0b0010
        //player?.physicsBody?.contactTestBitMask = 0b0010
        //yellowsquare?.physicsBody!.contactTestBitMask = 0b0010
        
        
    }
   
    func didMove(to view: GameScene){
        //physicsWorld.contactDelegate = (self as! SKPhysicsContactDelegate)
        //self.backgroundColor = .white
    }
    func didBegin(_ contact: SKPhysicsContact){
        
        var tempA = contact.bodyA.node?.name == "greensquare"
        var tempB = contact.bodyB.node?.name == "player"
        if(tempA && tempB){
            print("CONTACT DETECTED")
            winlabel!.text = "You win by contacting the green!"
        }
       }
    //let creates immutable variables -- var creates mutable variables.
    
    func touchDown(atPoint pos : CGPoint) {
        /*
        if(pos.x < -215 && pos.x > -265 && pos.y < -480 && pos.y > -530){
            player?.position = CGPoint(x:(player?.position.x)!, y:(player?.position.y)!+40)
            moves = moves + 1
            testtimer?.text = ("Moves:"+String(moves))
        }
        else if(pos.x < -215 && pos.x > -265 && pos.y < -575 && pos.y > -625){
            player?.position = CGPoint(x:(player?.position.x)!, y:(player?.position.y)!-40)
            moves = moves + 1
            testtimer?.text = ("Moves:"+String(moves))
        }
        else if(pos.x < -160 && pos.x > -210 && pos.y < -525 && pos.y > -575){
            player?.position = CGPoint(x:(player?.position.x)!+40, y:(player?.position.y)!)
            moves = moves + 1
            testtimer?.text = ("Moves:"+String(moves))
        }
        else if(pos.x < -265 && pos.x > -310 && pos.y < -525 && pos.y > -575){
            player?.position = CGPoint(x:(player?.position.x)!-40, y:(player?.position.y)!)
            moves = moves + 1
            testtimer?.text = ("Moves:"+String(moves))
        }
        */
        /*
        if let n = self.player?.copy() as! SKSpriteNode? {
            n.position = pos
            //n.strokeColor = SKColor.green
           // self.addChild(n)
            //class var mouseLocation : NSPoint {get}
            
            player?.position = pos // since pos is the pair of coordinates, it can be used to set coordinates of the SKNode 'player' in this instance
            //player?.position = CGPoint(x:200.6,y:310.4)
            //print(player?.anchorPoint)
        }*/
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
        /*
        //winlabel?.text = "Moving"
        //winlabel?.text = timer.get
        if let n = self.player?.copy() as! SKSpriteNode? {
            n.position = pos
            //n.strokeColor = SKColor.blue
            //self.addChild(n)
            player?.position = pos
            //player?.position = CGPoint(x:pos.x+100,y:pos.y+50)
            //redsquare?.position = CGPoint(x:Double.random(in: -350..<350),y: Double.random(in: -350..<350))
        }
         */
    }
    
    func touchUp(atPoint pos : CGPoint) {
        //These two print statements just print where x,y are on touchUp
        print("The current click position for x is:",pos.x)
        print("The current click position for y is:",pos.y)
        //These next 4 conditionals mimic button presses by detecting the range of x,y if it is within the
        //button-looking squares on the phone screen.  the coordinate ranges correspond to up/down/left/right
        if(pos.x < -215 && pos.x > -265 && pos.y < -480 && pos.y > -530){
            player?.position = CGPoint(x:(player?.position.x)!, y:(player?.position.y)!+40)
            moves = moves + 1
            testtimer?.text = ("Moves:"+String(moves))
        }
        else if(pos.x < -215 && pos.x > -265 && pos.y < -575 && pos.y > -625){
            player?.position = CGPoint(x:(player?.position.x)!, y:(player?.position.y)!-40)
            moves = moves + 1
            testtimer?.text = ("Moves:"+String(moves))
        }
        else if(pos.x < -160 && pos.x > -210 && pos.y < -525 && pos.y > -575){
            player?.position = CGPoint(x:(player?.position.x)!+40, y:(player?.position.y)!)
            moves = moves + 1
            testtimer?.text = ("Moves:"+String(moves))
        }
        else if(pos.x < -265 && pos.x > -310 && pos.y < -525 && pos.y > -575){
            player?.position = CGPoint(x:(player?.position.x)!-40, y:(player?.position.y)!)
            moves = moves + 1
            testtimer?.text = ("Moves:"+String(moves))
        }
        //These next lines will detect for angle roation.  I am not sure if two thumbs could be used on a real '
        //phone to detect both touches at the same time.
        if(pos.x < 265 && pos.x > 215 && pos.y < -525 && pos.y > -575){
            //print("you hit right white")
            //player?.zRotation = (player?.zPosition ?? 0.0) + CGFloat(40)
            player?.run(SKAction.rotate(byAngle: CGFloat(-0.1), duration: 0.1)) //player.run is a void type action like
                                                                                //when the spinnynodes were in the beginning example
        }
        else if(pos.x < 185 && pos.x > 135 && pos.y < -525 && pos.y > -575){
           //print("you hit left white")
            player?.run(SKAction.rotate(byAngle: CGFloat(0.1), duration: 0.1)) //player.run is a void type action like
                                                                                //when the spinnynodes were in the beginning example
        }
        //clicks for randomize:
        if(pos.x < -110 && pos.x > -270 && pos.y < 515 && pos.y > 485){
            greensquare?.position = CGPoint(x:Double.random(in: -300..<300),y:Double.random(in:-700..<700))
            yellowsquare?.position = CGPoint(x:Double.random(in: -300..<300),y:Double.random(in:-700..<700))
            yellowsquare1?.position = CGPoint(x:Double.random(in: -300..<300),y:Double.random(in:-700..<700))
            yellowsquare2?.position = CGPoint(x:Double.random(in: -300..<300),y:Double.random(in:-700..<700))
            player?.position = CGPoint(x:-12.425, y:-552.942)
            winlabel!.text = "Layout Randomized, Go Again!"
            moves = 0
            testtimer?.text = ("Moves:"+String(moves))
        }
        if(pos.x < 55 && pos.x > -31 && pos.y < 515 && pos.y > 485){
            greensquare?.position = CGPoint(x:-32.722,y:72.901)
            yellowsquare?.position = CGPoint(x:-32.821,y:14.803)
            yellowsquare1?.position = CGPoint(x:-90.821,y:73)
            yellowsquare2?.position = CGPoint(x:65.971,y:73)
            player?.position = CGPoint(x:-12.425, y:-552.942)
            winlabel?.numberOfLines = 2
            winlabel?.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            winlabel?.preferredMaxLayoutWidth = 1000
            winlabel!.text = "RESET!:\n PUSH THE GREEN OFF THE SCREEN!"
            moves = 0
            testtimer?.text = ("Moves:"+String(moves))
        }
        /*
        //winlabel?.text = "Stopped"
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
        
        //}
        */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let player = self.player {
//            player.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
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
        //greensquare?.position = CGPoint(x:(greensquare?.position.x)!+50,y:(greensquare?.position.y)!)
        //if((greensquare?.position.x)! > 350.0){
        //    greensquare?.position = CGPoint(x: -177.2, y:260.784)
        redsquare?.position = CGPoint(x:(redsquare?.position.x)!+10,y:(redsquare?.position.y)!)
        if((redsquare?.position.x)! > 350.0){
            redsquare?.position = CGPoint(x: -345, y:131)
        }
        redsquare2?.position = CGPoint(x:(redsquare2?.position.x)!+20,y:(redsquare2?.position.y)!)
        if((redsquare2?.position.x)! > 350.0){
            redsquare2?.position = CGPoint(x: -345, y:349)
        }
        redsquare3?.position = CGPoint(x:(redsquare3?.position.x)!-CGFloat(Double.random(in: 0..<30)),y:(redsquare3?.position.y)!)
        if((redsquare3?.position.x)! < -350.0){
            redsquare3?.position = CGPoint(x: 345, y:260)
        }
        if((greensquare?.position.y)! > CGFloat(750) || (greensquare?.position.y)! < -750 || (greensquare?.position.x)! > CGFloat(350) || (greensquare?.position.x)! < -350 ){
               //print("YOU WIN")
            winlabel!.text = ("YOU DID IT!")
            
        }
        //wincondition = (greensquare!.position.y > CGFloat(750) || greensquare!.position.y < CGFloat(750) || //greensquare!.position.x > CGFloat(350) || greensquare!.position.y < CGFloat(-350))
    }
   
    }

