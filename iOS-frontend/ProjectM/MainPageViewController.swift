//
//  MainPageViewController.swift
//  ProjectM
//
//  Created by Carlos Loeza on 10/28/21.
//

import Foundation
import AVFoundation // Access camera
import UIKit
import ARKit

class MainPageViewController: UIViewController{

    
    @IBOutlet weak var sceneView: ARSCNView!
    let config = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let text = SCNText(string: "Let's gooooo!", extrusionDepth: 2)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.blue
        text.materials = [material]
        
        let node = SCNNode()
        node.position = SCNVector3(x:0, y:0.02, z:-0.1)
        node.scale = SCNVector3(x:0.01, y:0.01, z:0.01)
        node.geometry = text
        
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.autoenablesDefaultLighting = true
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        sceneView.session.run(config)

    }

}
