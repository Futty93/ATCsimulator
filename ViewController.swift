//
//  ViewController.swift
//  ATCSimulator
//
//  Created by 二渡和輝 on 2023/05/28.
//

import Cocoa
import SpriteKit
import GameplayKit

//class ViewController: NSViewController {
//
//    @IBOutlet var skView: SKView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if let view = self.skView {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//            view.allowsMouseInteraction = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
//    }
//}

class ViewController: NSViewController {
//    override func loadView() {
//        let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 1280, height: 960))
//        let scene = GameScene(size: sceneView.frame.size)
//        scene.scaleMode = .aspectFill
//        sceneView.presentScene(scene)
//
//        self.view = sceneView
//    }
    
    override func loadView() {
        let mainView = NSView(frame: NSRect(x: 0, y: 0, width: 1260, height: 960))
        
        let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 960, height: 960))
        let scene = GameScene(size: sceneView.frame.size)
        scene.scaleMode = .aspectFill
        sceneView.presentScene(scene)
        mainView.addSubview(sceneView)
        
        let controlPanelView = SKView(frame: CGRect(x: 960, y: 0, width: 300, height: 960))
        let controlPanelScene = ControlPanelScene(size: controlPanelView.frame.size)
        controlPanelScene.scaleMode = .aspectFill
        controlPanelView.presentScene(controlPanelScene)
        mainView.addSubview(controlPanelView)
        
        self.view = mainView
    }
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let skView = view as? SKView {
            skView.window?.makeFirstResponder(skView)
            skView.allowedTouchTypes = [.direct]
        }
    }
}
