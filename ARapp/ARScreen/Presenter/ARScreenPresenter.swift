//
//  ARScreenPresenter.swift
//  ARapp
//
//  Created by Max Nechaev on 27.11.2021.
//

import UIKit
import ARKit

class ARScreenPresenter: IARScreenView {
    
    func createVirtualObject(hitResult: ARHitTestResult, sceneView: ARSCNView, objectName: String) {
        let position = SCNVector3(hitResult.worldTransform.columns.3.x,
                                  hitResult.worldTransform.columns.3.y,
                                  hitResult.worldTransform.columns.3.z)

        if let virtualObject = VirtualObject.getObject(name: objectName) {
            virtualObject.position = position
            virtualObject.load()
            sceneView.scene.rootNode.addChildNode(virtualObject)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor, planes: inout [ARPlane]) {
        guard anchor is ARPlaneAnchor else { return }
        
        let plane = ARPlane(anchor: anchor as! ARPlaneAnchor)
        
        planes.append(plane)
        node.addChildNode(plane)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor, planes: [ARPlane]) {
        let plane = planes.filter { plane in
            return plane.anchor.identifier == anchor.identifier
        }.first
        
        guard plane != nil else { return }
        
        plane?.update(anchor: anchor as! ARPlaneAnchor)
    }
}
