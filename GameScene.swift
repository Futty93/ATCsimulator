//
//  GameScene.swift
//  ATCSimulator
//
//  Created by 二渡和輝 on 2023/05/28.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var aircraftNodes: [SKShapeNode] = []
    var numberOfAircraft: Int = 8
    var movementSpeed: CGFloat = 1.0 // Pixels per second
    
    override func didMove(to view: SKView) {
        let aircraftSize = CGSize(width: 10, height: 10)
        //        let spacing: CGFloat = 100
        
        for i in 0..<numberOfAircraft {
            let aircraftNode = SKShapeNode(rectOf: aircraftSize)
            //            aircraftNode.fillColor = .white
            // Set random initial position
            let randomX = CGFloat.random(in: 0...(frame.width - aircraftSize.width))
            let randomY = CGFloat.random(in: 0...(frame.height - aircraftSize.height))
            aircraftNode.position = CGPoint(x: randomX, y: randomY)
            
            // Add number label
            let labelNode = SKLabelNode(text: "\(i+1)")
            labelNode.position = CGPoint(x: aircraftNode.position.x, y: aircraftNode.position.y - 30)
            addChild(labelNode)
            
            addChild(aircraftNode)
            aircraftNodes.append(aircraftNode)
        }
    }
    
    //    override func update(_ currentTime: TimeInterval) {
    //        //        let deltaTime = CGFloat(self.deltaTime)
    //
    //        // Move each aircraft node horizontally
    //        for aircraftNode in aircraftNodes {
    //            aircraftNode.position.x += movementSpeed
    //        }
    //    }
    
    override func update(_ currentTime: TimeInterval) {
        //            let deltaTime = CGFloat(self.deltaTime)
        
        // Move each aircraft node towards the center
        //        for aircraftNode in aircraftNodes {
        //            let dx = frame.midX - aircraftNode.position.x
        //            let dy = frame.midY - aircraftNode.position.y
        //            let distanceToCenter = hypot(dx, dy)
        //
        //            // Move towards the center with a speed relative to the distance
        //            let movementAmount = min(movementSpeed, distanceToCenter)
        //            let angle = atan2(dy, dx)
        //            let dxMove = movementAmount * cos(angle)
        //            let dyMove = movementAmount * sin(angle)
        //
        //            aircraftNode.position.x += dxMove
        //            aircraftNode.position.y += dyMove
        //
        //
        //        }
        for (index, aircraftNode) in aircraftNodes.enumerated() {
            let dx = frame.midX - aircraftNode.position.x
            let dy = frame.midY - aircraftNode.position.y
            let distanceToCenter = hypot(dx, dy)
            
            // Move towards the center with a speed relative to the distance
            let movementAmount = min(movementSpeed, distanceToCenter)
            let angle = atan2(dy, dx)
            let dxMove = movementAmount * cos(angle)
            let dyMove = movementAmount * sin(angle)
            
            aircraftNode.position.x += dxMove
            aircraftNode.position.y += dyMove
            
            // Update label position
            let labelNode = children[index * 2 + 1] as? SKLabelNode
            labelNode?.position.x = aircraftNode.position.x
            labelNode?.position.y = aircraftNode.position.y - 30
            
        }
    }
}
