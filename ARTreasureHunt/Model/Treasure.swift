//
//  Treasure.swift
//  ARTreasureHunt
//
//  Created by Ahsen Bahtışen on 19.06.2023.
//

import ARKit
import MapKit

class Treasure: SCNNode {
    
    var treasureAnnotation: MKPointAnnotation?
    var treasureNode: SCNNode?
    
    func loadModel() {
        guard let virtualObjectScene = SCNScene(named: "art.scnassets/treasure.scn") else {return}
                let wrapperNode = SCNNode()
                for child in virtualObjectScene.rootNode.childNodes {
                    wrapperNode.addChildNode(child)
                }
        
        
        self.addChildNode(wrapperNode)
        self.treasureNode = wrapperNode
    }
}
