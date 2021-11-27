//
//  ARPlane.swift
//  ARapp
//
//  Created by Max Nechaev on 27.11.2021.
//

import ARKit
import SceneKit

class ARPlane: SCNNode {
    
    //MARK: - Variables
    
    var anchor: ARPlaneAnchor
    var planeGeometry: SCNPlane!
    
    //MARK: - Init
    
    init(anchor: ARPlaneAnchor) {
        self.anchor = anchor
        super.init()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func configure() {
        planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "pinkWeb")
        
        planeGeometry.materials = [material]
        
        self.geometry = planeGeometry
        self.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        self.transform = SCNMatrix4MakeRotation(Float(-Double.pi / 2), 1.0, 0.0, 0.0)
    }

    func update(anchor: ARPlaneAnchor) {
        planeGeometry.width = CGFloat(anchor.extent.x)
        planeGeometry.height = CGFloat(anchor.extent.z)
        self.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
    }
}
