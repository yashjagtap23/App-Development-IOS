//
//  GameScene.swift
//  SpaceInvaders
//
//  Created by Yash Jagtap 2024 on 4/21/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    var levelTimerLabel = SKLabelNode(fontNamed: "ArialMT")
    let tgMusic = SKAudioNode(fileNamed: "top_gun_anthem")
    
    var levelTimerValue: Int = 30 {
        didSet {
            levelTimerLabel.text = "Time left: \(levelTimerValue)"
        }
    }
    
    var plane = SKSpriteNode()
  
    var playerScoreLabel = SKLabelNode()
  
    var count = 0
    var enemiesKilled = 0
    var wowCount = 0
    var lossCount = 0
    var isOnplane = false
    var playerScore = 0
    var counter = 0.0
  
    struct PhysicsCategory
    {
       static let None: UInt32 = 0
        static let Enemy: UInt32 = 0b1
        static let Plane: UInt32 = 0b11
        static let Bullet: UInt32 = 0b10
    }
    
    override func didMove(to view: SKView)
    {
        
        tgMusic.autoplayLooped = true
        addChild(tgMusic)
        
        physicsWorld.contactDelegate = self
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0.0
        self.physicsBody = borderBody
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        
        plane = childNode(withName: "plane") as! SKSpriteNode
        plane.physicsBody = SKPhysicsBody(rectangleOf: plane.size)
        plane.physicsBody?.isDynamic = true
        plane.physicsBody?.categoryBitMask = PhysicsCategory.None
        plane.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        plane.physicsBody?.collisionBitMask = PhysicsCategory.Plane

  
        physicsWorld.contactDelegate = self
        
        setUpLabels()
        
        run(SKAction.repeat(SKAction.sequence([SKAction.run(addEnemies), SKAction.wait(forDuration: 1.0)]), count: 10))
        
        
        levelTimerLabel.fontColor = SKColor.red
        levelTimerLabel.fontSize = 50
        levelTimerLabel.position = CGPoint(x: size.width/6.5, y: size.height/2 + 330)
        levelTimerLabel.text = "Time left: \(levelTimerValue)"
       
        addChild(levelTimerLabel)

        let wait = SKAction.wait(forDuration: 0.5) //change countdown speed
        let block = SKAction.run({
                [unowned self] in
                
                if self.levelTimerValue > 0{
                    self.levelTimerValue = levelTimerValue - 1
                    if(self.levelTimerValue == 0)
                    {
                        count += 1                    }
                    updateLabels()
                }else{
                    self.removeAction(forKey: "countdown")
                }
            })
            let sequence = SKAction.sequence([wait,block])

        run(SKAction.repeatForever(sequence), withKey: "countdown")
        
    }
    
   
    
    func setUpLabels()
    {
        playerScoreLabel = SKLabelNode(fontNamed: "Arial")
        playerScoreLabel.text = "Player Score: \(playerScore)"
        playerScoreLabel.fontSize = 40
        playerScoreLabel.position = CGPoint(x: frame.width * 0.5, y: frame.height * 0.9)
        playerScoreLabel.fontColor = .black
        addChild(playerScoreLabel)
        
    }
    func updateLabels()
    {
       
        if(count == 0){
            playerScoreLabel.text = "Player Score: \(playerScore)"
        }
        if(enemiesKilled == 10 && wowCount == 0)
        {
          
            run(SKAction.playSoundFileNamed("2968", waitForCompletion: true))
            removeAction(forKey: "countdown")
            let wow = SKSpriteNode(imageNamed: "wow")
            wow.position = CGPoint(x: frame.midX, y: frame.midY)
            wow.zPosition = 10
            wow.xScale = 0.001
            wow.yScale = 0.001
            addChild(wow)
            wowCount += 1
            
            let appear = SKAction.group([
                SKAction.scale(to: 0.9, duration: 0.25),
                SKAction.fadeIn(withDuration: 0.25)
            ])
            
            let dissapear = SKAction.group([SKAction.scale(to: 2, duration: 0.25), SKAction.fadeOut(withDuration: 0.25)])
            
            let sequence = SKAction.sequence([appear, SKAction.wait(forDuration: 0.25), dissapear])
            wow.run(sequence)
        }
        if(count == 1)
        {

    
            
            run(SKAction.playSoundFileNamed("2960", waitForCompletion: true))
            removeAction(forKey: "countdown")
            playerScoreLabel.fontSize = 80
            playerScoreLabel.position = CGPoint(x: frame.width * 0.5, y: frame.height * 0.85)
            playerScoreLabel.text = "YOU LOSE!"
            let loss = SKSpriteNode(imageNamed: "wasted")
            loss.position = CGPoint(x: frame.midX, y: frame.midY)
            loss.zPosition = 10
            loss.xScale = 0.001
            loss.yScale = 0.001
            addChild(loss)
            lossCount += 1
            
            let appear = SKAction.group([
                SKAction.scale(to: 1.5, duration: 0.75),
                SKAction.fadeIn(withDuration: 1.5)
            ])
            
            let dissapear = SKAction.group([SKAction.scale(to: 5, duration: 0.25), SKAction.fadeOut(withDuration: 0.25)])
            
            let sequence = SKAction.sequence([appear, SKAction.wait(forDuration: 0.25), dissapear])
            loss.run(sequence)
            count += 1
        }
       
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        if(plane.frame.contains(location)){
            isOnplane = true
        }
        }
           
   
           
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        if(isOnplane)
            {
            
            plane.position = CGPoint(x: location.x, y: location.y)
        }
        }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch = touches.first else
        {
            return
        }
        let touchLocation = touch.location(in: self)

        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.position = plane.position
        if(count == 0){
            addChild(bullet)
            counter = counter + 1
            run(SKAction.playSoundFileNamed("blaster-2-81267", waitForCompletion: false))
        }
        let difference = touchLocation - bullet.position
        
        let direction = difference.normalized()
        let shootAmount = direction * 1000
        
        let destination = bullet.position + shootAmount
        
        let actionMove = SKAction.move(to: destination, duration: 2.0)
        
        let actionDone = SKAction.removeFromParent()
        bullet.run(SKAction.sequence([actionMove, actionDone]))
       
        
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width/2)
        bullet.physicsBody?.isDynamic = true
        bullet.physicsBody?.categoryBitMask = PhysicsCategory.Bullet
        bullet.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        bullet.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        
      
    }
    func didBegin(_ contact: SKPhysicsContact) {
      
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
      
        
        if let enemy = firstBody.node as? SKSpriteNode, let bullet = secondBody.node as? SKSpriteNode
        {
            if(firstBody.node?.name == "plane" || secondBody.node?.name == "plane")
            {
                collisionPlaneWithEnemy(enemy: enemy, plane: plane)
            }
            else
            {
                collisionBulletWithEnemy(bullet: bullet, enemy: enemy)
            }
        }
        updateLabels()
        
    }
    func random()->CGFloat
    {
        return CGFloat.random(in: 0.0...1.0)
    }
    func random(min: CGFloat, max: CGFloat)->CGFloat
    {
        return random() * (max - min) + min
    }
    func addEnemies()
    {
        if(count == 0){
            var enemy = SKSpriteNode(imageNamed: "enemy")
            let actualY = random(min: enemy.size.height/2, max: size.height - enemy.size
                .height/2)
            let actualX = random(min: enemy.size.width/2, max: size.width - enemy.size
                .height/2)
            enemy.position = CGPoint(x: actualX, y: actualY)
            enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
            enemy.physicsBody?.isDynamic = true
            enemy.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
            enemy.physicsBody?.contactTestBitMask = PhysicsCategory.Bullet
            enemy.physicsBody?.collisionBitMask = PhysicsCategory.None
            addChild(enemy)
        }
    }

    func collisionBulletWithEnemy(bullet: SKSpriteNode, enemy: SKSpriteNode)
    {
       
        enemiesKilled += 1
        print("Dead")
        bullet.removeFromParent()
        enemy.removeFromParent()
        playerScore = playerScore + 1
       
    }
    
    func collisionPlaneWithEnemy(enemy: SKSpriteNode, plane: SKSpriteNode)
    {
    
        
        print("Dead")
        plane.removeFromParent()
        enemy.removeFromParent()
        count += 1
        playerScoreLabel.text = "YOU LOSE!"
        
       
    }
}

