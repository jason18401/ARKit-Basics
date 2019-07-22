//
//  ViewController.swift
//  World Tracking
//
//  Created by Jason Yu on 7/21/19.
//  Copyright © 2019 Jason Yu. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let config = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(config, options: .init())
        self.sceneView.automaticallyUpdatesLighting = true
    }

    @IBAction func addButton(_ sender: Any) {
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        node.geometry?.firstMaterial?.specular.contents = UIColor.white //light
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        let x = randomNumbers(minNum: -0.3, maxNum: 0.3)
        let y = randomNumbers(minNum: -0.3, maxNum: 0.3)
        let z = randomNumbers(minNum: -0.3, maxNum: 0.3)
        
        node.position = SCNVector3(x, y, z)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func resetButton(_ sender: Any) {
        self.resetSession()
    }
    
    func resetSession(){
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes{(node, stop) in node.removeFromParentNode()
            
        }
        self.sceneView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(minNum: CGFloat, maxNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(minNum - maxNum) + min(minNum, maxNum)
    }
}

