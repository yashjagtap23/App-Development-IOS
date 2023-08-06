//
//  GameScene.swift
//  CandyCrush
//
//  Created by Yash Jagtap 2024 on 4/17/23.
//

import SpriteKit
import GameplayKit
import CoreMotion

class Ball: SKSpriteNode{}

class GameScene: SKScene {
    var scoreLabel: SKLabelNode!
    var motionManager: CMMotionManager?
    
    
    
    var balls  = ["ballBlue","ballYellow","ballPurple","ballGreen","ballRed","ballCyan","ballGrey"]
    var matchedBalls = Set<Ball>()
    var score: Int = 0
    {
        didSet
        { scoreLabel.text = "SCORE: \(score)"
      
        }
    }
    
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "checkerboard")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.alpha = 0.2
        background.zPosition = -1
        addChild(background)
       
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
        
        let ball = SKSpriteNode(imageNamed: "ballGreen")
        let ballRadius = ball.frame.width / 2.0
        
        for i in stride(from: ballRadius, to: view.bounds.width - ballRadius, by: ball.frame.width)
        {
            for j in stride(from: ballRadius, to: view.bounds.height - ballRadius, by: ball.frame.height)
            {
                let ballType = balls.randomElement()!
                let ball = Ball(imageNamed: ballType)
                ball.position = CGPoint(x: i, y: j)
                ball.name = ballType
                addChild(ball)
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
                ball.physicsBody?.allowsRotation = false
                ball.physicsBody?.friction = 0
                ball.physicsBody?.restitution = 0
            }
        }
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)))
        
    }
    override func update(_ currentTime: TimeInterval) {

        
        
        if let accelerometerData = motionManager?.accelerometerData
        {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }


    }
    func getMatches(from node: Ball)
    {
        for body in node.physicsBody!.allContactedBodies()
        {
            guard let ball = body.node as? Ball else {continue}
            guard ball.name == node.name else {continue}
            
            if !matchedBalls.contains(ball)
            {
                matchedBalls.insert(ball)
                getMatches(from: ball)
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let position = touches.first?.location(in: self) else {return}
        guard let tappedBall = nodes(at: position).first(where: {$0 is Ball}) as? Ball else {return}
        matchedBalls.removeAll(keepingCapacity: true)
        getMatches(from: tappedBall)
        if matchedBalls.count >= 3
        {
            score += Int(pow(2, Double(min(matchedBalls.count, 16))))
            for ball in matchedBalls
            {
                if let particles = SKEmitterNode(fileNamed: "smoke1")
                {
                    particles.position = ball.position
                    addChild(particles)
                    let removeNodes = SKAction.sequence([SKAction.wait(forDuration: 2), SKAction.removeFromParent()])
                    particles.run(removeNodes)
                }
                ball.removeFromParent()
            }
        }
        if matchedBalls.count >= 5
        {
            let omg = SKSpriteNode(imageNamed: "omg")
            omg.position = CGPoint(x: frame.midX, y: frame.midY)
            omg.zPosition = 5
            omg.xScale = 0.001
            omg.yScale = 0.001
            addChild(omg)
            
            let appear = SKAction.group([
                SKAction.scale(to: 1, duration: 0.25),
                SKAction.fadeIn(withDuration: 0.25)
            ])
            
            let dissapear = SKAction.group([SKAction.scale(to: 2, duration: 0.25), SKAction.fadeOut(withDuration: 0.25)])
            
            let sequence = SKAction.sequence([appear, SKAction.wait(forDuration: 0.25), dissapear])
            omg.run(sequence)
        }
    }
}
