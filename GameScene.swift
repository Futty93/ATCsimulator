//
//  GameScene.swift
//  ATCSimulator
//
//  Created by 二渡和輝 on 2023/05/28.
//

import SpriteKit
import GameplayKit

class ControlPanelScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = .gray
        
        // Add your control panel UI elements here
    }
}

class GameScene: SKScene {
    let flightNumbers = ["ANA", "JAL", "APJ", "SKY", "ADO", "FDA", "SFJ", "SNJ", "JTA"]
    var aircraftNodes: [Aircraft] = []
    var numberOfAircraft: Int = 8 //表示する航空機の数
    
    
    override func didMove(to view: SKView) {
        
        
        for _ in 0..<numberOfAircraft {
            createRandomAircraft()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        // Move each aircraft node towards the center
        for aircraftNode in aircraftNodes {
            let dx = frame.midX - aircraftNode.position.x
            let dy = frame.midY - aircraftNode.position.y
            let distanceToCenter = hypot(dx, dy)
            
            if distanceToCenter < 50 {
                aircraftNode.removeFromParent()
                aircraftNodes.removeAll(where: { $0 == aircraftNode })
                aircraftNode.labelNode?.removeFromParent() // Remove label node from parent
                createRandomAircraft()
            }
            
            // Move towards the center with a speed relative to the distance
            let movementAmount = min(aircraftNode.movementSpeed, distanceToCenter)
            let angle = atan2(dy, dx)
            let dxMove = movementAmount * cos(angle)
            let dyMove = movementAmount * sin(angle)
            
            aircraftNode.position.x += dxMove
            aircraftNode.position.y += dyMove
            aircraftNode.labelNode?.position.x = 25
            aircraftNode.labelNode?.position.y = 25
            
            aircraftNode.labelNode?.text = """
                \(aircraftNode.flightCode)
                Heading: \(aircraftNode.currentHeading)
            """
            
        }
    }
    
    func createRandomAircraft() {
        let center = CGPoint(x: size.width/2, y: size.height/2)
        let aircraftSize = CGSize(width: 5, height: 5)
        //        let spacing: CGFloat = 100
        let aircraftNode = Aircraft(rectOf: aircraftSize)
        aircraftNode.fillColor = .clear
        aircraftNode.strokeColor = .white
        
        // Set random initial position
        let randomX = CGFloat.random(in: 0...(frame.width - aircraftSize.width))
        let randomY = CGFloat.random(in: 0...(frame.height - aircraftSize.height))
        aircraftNode.position = CGPoint(x: randomX, y: randomY)
//        aircraftNode.labelNode?.position = CGPoint(x: aircraftNode.position.x, y: aircraftNode.position.y - 30)
        
        let directionToCenter = CGPoint(x: center.x - aircraftNode.position.x, y: center.y - aircraftNode.position.y)
//        aircraftNode.currentHeading = atan2(directionToCenter.y, directionToCenter.x)
        //headingの計算用に利用する偏角のラジアンを返す。(-π~π)
        let headDigree = atan2(directionToCenter.y, directionToCenter.x)
        var Heading:Int = Int(headDigree * 180 / CGFloat.pi)
        //北を0、南を180としてcurentHeadingに代入する
        if Heading < 0 {
            Heading = Int(90 - Heading)
        }else if Heading > 90 {
            Heading = Int(360 - (Heading - 90))
        }else{
            Heading = Int(90 - Heading)
        }
        aircraftNode.currentHeading = Heading
        //コールサインを生成
        let randomFlightNumber = flightNumbers.randomElement() ?? ""
        let randomFlightID = Int.random(in: 10...2000)
        aircraftNode.flightCode = randomFlightNumber + String(randomFlightID)
//        flightLabel.position = CGPoint(x: 25, y: 25)
//        flightLabel.fontColor = .white
//        flightLabel.fontSize = 12
        let flightLabel = SKLabelNode(text: "\(aircraftNode.flightCode)\nHeading: \(aircraftNode.currentHeading)")
//        flightLabel.position = CGPoint(x: 25, y: 25)
        flightLabel.fontColor = .white
        flightLabel.fontSize = 12
        aircraftNode.addChild(flightLabel)
        
        aircraftNode.labelNode = flightLabel
        
        addChild(aircraftNode)
//        addChild(aircraftNode.labelNode!)
        aircraftNodes.append(aircraftNode)
    }
}


class Aircraft: SKShapeNode {
    var labelNode: SKLabelNode?
    var movementSpeed: CGFloat = 0.1 // Pixels per second
    var currentHeading: Int = 0 // Initial heading towards the center of the screen
    var flightCode: String = ""
    
    var isSelected: Bool = false {
        didSet {
            if isSelected {
                fillColor = .green
            } else {
                fillColor = .clear
            }
        }
    }
    
    override var isUserInteractionEnabled: Bool {
        set {}
        get { return true }
    }
    
    override func mouseDown(with event: NSEvent) {
        let touchLocation = event.location(in: self)
        if contains(touchLocation) {
            isSelected.toggle()
        }
    }
}
