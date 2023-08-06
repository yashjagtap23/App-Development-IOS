//
//  GameScene.swift
//  GravityGame14.2
//
//  Created by Jodi Scott on 2/17/23.
//

import SpriteKit
import CoreMotion

enum CollisionTypes: UInt32
{
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
}

class GameScene: SKScene,SKPhysicsContactDelegate
{
    
    var player: SKSpriteNode!
    var lastTouchPosition: CGPoint?
    var isGameOver = false
    var scoreLabel: SKLabelNode!
    var motionManager: CMMotionManager?
    
    //add score and didSet
    var score = 0
    {
        didSet
        {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    //didSet
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        //add score Label
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        
        
        loadLevel()
        createPlayer()
        
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = .zero
        
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
        
        
    }
    func loadLevel()
    {
        guard let levelURL = Bundle.main.url(forResource: "level1", withExtension: "txt") else { fatalError("Could not load level1.text from the app bundle.")}
        
        guard let levelString = try? String(contentsOf: levelURL) else {return}
        
        let lines = levelString.components(separatedBy: "\n")
        for (row, line) in lines.reversed().enumerated()
        {
            for (column, letter) in line.enumerated()
            {
                let position = CGPoint(x:(64 * column) + 32, y: (64*row) - 32)
                if letter == "x"
                {
                    let node = SKSpriteNode(imageNamed: "block")
                    node.position = position
                    node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                    node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
                    node.physicsBody?.isDynamic = false
                    addChild(node)
                    
                }
                else if letter == "v"
                {
                    let node = SKSpriteNode(imageNamed: "vortex")
                    node.name = "vortex"
                    node.position = position
                    node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    addChild(node)
                }
                else if letter == "s"
                {
                    let node = SKSpriteNode(imageNamed: "star")
                    node.name = "star"
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    node.position = position
                    addChild(node)
                }
                else if letter == "f"
                {
                    let node = SKSpriteNode(imageNamed: "finish")
                    node.name = "finish"
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.categoryBitMask = CollisionTypes.finish .rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    node.position = position
                    addChild(node)
                }
                else if letter == " "
                {
                    //do nothing
                }
                else
                {
                    fatalError("Cannot find letter: \(letter)")
                }
            }
        }
        
    }
    
    func loadLevel2()
    {
        guard let levelURL = Bundle.main.url(forResource: "level2", withExtension: "txt") else { fatalError("Could not load level2.text from the app bundle.")}
        
        guard let levelString = try? String(contentsOf: levelURL) else {return}
        
        let lines = levelString.components(separatedBy: "\n")
        for (row, line) in lines.reversed().enumerated()
        {
            for (column, letter) in line.enumerated()
            {
                let position = CGPoint(x:(64 * column) + 32, y: (64*row) - 32)
                if letter == "x"
                {
                    let node = SKSpriteNode(imageNamed: "block")
                    node.position = position
                    node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                    node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
                    node.physicsBody?.isDynamic = false
                    addChild(node)
                    
                }
                else if letter == "v"
                {
                    let node = SKSpriteNode(imageNamed: "vortex")
                    node.name = "vortex"
                    node.position = position
                    node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    addChild(node)
                }
                else if letter == "s"
                {
                    let node = SKSpriteNode(imageNamed: "star")
                    node.name = "star"
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    node.position = position
                    addChild(node)
                }
                else if letter == "f"
                {
                    let node = SKSpriteNode(imageNamed: "finish")
                    node.name = "finish2"
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.categoryBitMask = CollisionTypes.finish .rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    node.position = position
                    addChild(node)
                }
                else if letter == " "
                {
                    //do nothing
                }
                else
                {
                    fatalError("Cannot find letter: \(letter)")
                }
            }
        }
    }
    
    func loadLevel3()
    {
        guard let levelURL = Bundle.main.url(forResource: "level3", withExtension: "txt") else { fatalError("Could not load level3.text from the app bundle.")}
        
        guard let levelString = try? String(contentsOf: levelURL) else {return}
        
        let lines = levelString.components(separatedBy: "\n")
        for (row, line) in lines.reversed().enumerated()
        {
            for (column, letter) in line.enumerated()
            {
                let position = CGPoint(x:(64 * column) + 32, y: (64*row) - 32)
                if letter == "x"
                {
                    let node = SKSpriteNode(imageNamed: "block")
                    node.position = position
                    node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                    node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
                    node.physicsBody?.isDynamic = false
                    addChild(node)
                    
                }
                else if letter == "v"
                {
                    let node = SKSpriteNode(imageNamed: "vortex")
                    node.name = "vortex"
                    node.position = position
                    node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    addChild(node)
                }
                else if letter == "s"
                {
                    let node = SKSpriteNode(imageNamed: "star")
                    node.name = "star"
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    node.position = position
                    addChild(node)
                }
                else if letter == "f"
                {
                    let node = SKSpriteNode(imageNamed: "finish")
                    node.name = "finish3"
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.categoryBitMask = CollisionTypes.finish .rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    node.position = position
                    addChild(node)
                }
                else if letter == " "
                {
                    //do nothing
                }
                else
                {
                    fatalError("Cannot find letter: \(letter)")
                }
            }
        }
    }
    func createPlayer()
    {
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 96, y: 672)
        player.zPosition = 1
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5
        player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        
        player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue
        player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
        addChild(player)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        lastTouchPosition = nil
    }
    override func update(_ currentTime: TimeInterval) {
        guard isGameOver == false else {return}
        
        #if targetEnvironment(simulator)
        if let lastTouchPosition = lastTouchPosition
        {
            let diff = CGPoint(x: lastTouchPosition.x - player.position.x, y: lastTouchPosition.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
        #else
        if let accelerometerData = motionManager?.accelerometerData
        {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
        #endif

    }
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        if nodeA == player
        {
            playerCollided(with: nodeB)
        }
        else if nodeB == player
        {
            playerCollided(with: nodeA)
        }
    }
    func playerCollided(with node: SKNode)
    {
        if node.name == "vortex"
        {
            player.physicsBody?.isDynamic = false
            isGameOver = true
            score -= 1
            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move,scale,remove])
            player.run(sequence)
            {
                [weak self] in
                self?.createPlayer()
                self?.isGameOver = false
            }
        }
        else if node.name == "star"
        {
            node.removeFromParent()
            score += 1
        }
        else if node.name == "finish"
        {
            removeAllChildren()
                loadLevel2()
                createPlayer()
                
                let background = SKSpriteNode(imageNamed: "background")
                background.position = CGPoint(x: 512, y: 384)
                background.blendMode = .replace
                background.zPosition = -1
                addChild(background)
                
                //add score Label
                
                scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
                scoreLabel.text = "Score: 0"
                scoreLabel.horizontalAlignmentMode = .left
                scoreLabel.position = CGPoint(x: 16, y: 16)
                scoreLabel.zPosition = 2
                addChild(scoreLabel)
            }
        
        else if node.name == "finish2"
        {
            removeAllChildren()
                loadLevel3()
                createPlayer()
                
                let background = SKSpriteNode(imageNamed: "background")
                background.position = CGPoint(x: 512, y: 384)
                background.blendMode = .replace
                background.zPosition = -1
                addChild(background)
                
                //add score Label
                
                scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
                scoreLabel.text = "Score: 0"
                scoreLabel.horizontalAlignmentMode = .left
                scoreLabel.position = CGPoint(x: 16, y: 16)
                scoreLabel.zPosition = 2
                addChild(scoreLabel)
            }
        else if node.name == "finish3"
        {
            removeAllChildren()
            let background = SKSpriteNode(imageNamed: "background")
            background.position = CGPoint(x: 512, y: 384)
            background.blendMode = .replace
            background.zPosition = -1
            addChild(background)
            
            let winner = SKLabelNode(fontNamed: "Chalkduster")
            winner.text = "You Win!"
            winner.fontSize = 65
            winner.fontColor = SKColor.green
            winner.position = CGPoint(x: frame.midX, y: frame.midY)
               
            addChild(winner)
            }
            
        }
    }

