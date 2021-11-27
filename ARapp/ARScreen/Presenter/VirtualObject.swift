//
//  VirtualObject.swift
//  ARapp
//
//  Created by Max Nechaev on 27.11.2021.
//

import SceneKit

class VirtualObject: SCNReferenceNode {
    
    static func getObject(name: String) -> SCNReferenceNode? {
        guard let modelsURLs = Bundle.main.url(forResource: "art.scnassets", withExtension: nil) else { return nil }
        
        let fileEnumerator = FileManager().enumerator(at: modelsURLs, includingPropertiesForKeys: nil)!
        return fileEnumerator.compactMap { element in
            let url = element as! URL
            guard url.pathExtension == "usdz" else { return nil }
            
            let urlString = url.absoluteString
            guard urlString.contains(name) else { return nil }
            
            return VirtualObject(url: url)
        }.first ?? nil
    }
}
