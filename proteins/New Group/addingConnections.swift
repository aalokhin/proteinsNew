//
//  addingConnections.swift
//  proteins
//
//  Created by ANASTASIA on 7/24/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation
import SceneKit

extension ProteinVisVC {
    
    func allConnections() -> SCNNode{
        let connectionsNode = SCNNode()
        
        for one in self.connectionStrings {
            let split = one.toSingleSpaceLine().components(separatedBy: " ")
            let conNbr = split.count - 1
            let currentElInd : Int = split[1].toInt()
            
            guard let index = atoms.firstIndex(where: { (item) -> Bool in
                item.sequenceNbr == currentElInd
            }) else {
                print("there is no atom with sequence number \(currentElInd)")
                continue
            }
            
            let firstAtom = atoms[index]
            var i : Int = 2
            while (i <= conNbr){
                guard let index = atoms.firstIndex(where: { (item) -> Bool in
                    item.sequenceNbr == split[i].toInt()
                }) else {
                    print("there is no suhc connection in str \"\(one)\" i = \(i)")
                    i+=1
                    continue
                }
                
                let atomToConnect = atoms[index]
                
                let unit = connectionCylinderNode(startPoint : firstAtom.position(), endPoint: atomToConnect.position(), color: UIColor.darkGray, radius : 0.08)
                if (checkIfNodeEsists(parent : connectionsNode, unit : unit) == false){
                    /*we need to add something here*/
                    bondsNbr+=1
                    connectionsNode.addChildNode(unit)
                }
                i+=1
            }
        }
        print("here we go these are number of bonds=> \(bondsNbr)")
        return connectionsNode
    }
    //this seems to be no good
    func checkIfNodeEsists(parent : SCNNode, unit : SCNNode) -> Bool{
        for child in parent.childNodes as [SCNNode] {
            if (child.position.x == unit.position.x && child.position.y == unit.position.y && child.position.z == unit.position.z && child.position.length == unit.position.length) {
                //print("Node already exists")
                return true
            }
        }
        return false
        
    }
    
    
    
    //https://stackoverflow.com/questions/35002232/draw-scenekit-object-between-two-points
    //http://qaru.site/questions/1625903/draw-scenekit-object-between-two-points
    
    
    func connectionCylinderNode(startPoint : SCNVector3, endPoint: SCNVector3, color : UIColor, radius : CGFloat) -> SCNNode {
        let vector = SCNVector3Make(endPoint.x - startPoint.x, endPoint.y - startPoint.y, endPoint.z - startPoint.z)
        let vX = startPoint.x + endPoint.x
        let vY = startPoint.y + endPoint.y
        let vZ = startPoint.z + endPoint.z
        let node = getCylinderNode(color: color, radius : radius, vector: vector)
        node.position = SCNVector3Make(vX/2, vY/2, vZ/2)
        node.eulerAngles = eulerAngles(vector : vector, height : vector.length)
        return node
    }
    
    func getCylinderNode(color : UIColor, radius : CGFloat, vector : SCNVector3) -> SCNNode {
        let height = sqrtf(vector.x*vector.x + vector.y*vector.y + vector.z*vector.z)
        let cylinder = SCNCylinder(radius: radius, height: CGFloat(height))
        cylinder.radialSegmentCount = 4
        cylinder.firstMaterial!.diffuse.contents = color
        return SCNNode(geometry: cylinder)
    }
    
    func eulerAngles(vector : SCNVector3, height : Float) -> SCNVector3 {
        let sqrLxz = vector.x * vector.x + vector.z * vector.z
        let lxz = sqrtf(sqrLxz)
        var pitchB : Float
        var pitch : Float
        
        if (vector.y < 0) {
             pitchB = Float.pi - asinf(lxz/height)
        } else {
             pitchB = asinf(lxz/height)
        }
        if (vector.z == 0){
            pitch = pitchB
        } else {
            pitch = sign(vector.z) * pitchB
        }
        
        let yaw : Float = getYaw(vector : vector, height : height, pitch : pitch)
        return SCNVector3(CGFloat(pitch), CGFloat(yaw), 0)
    }
    
    func getYaw (vector : SCNVector3, height : Float, pitch : Float) -> Float {
        var yaw : Float = 0
        if (vector.z != 0 || vector.x != 0) {
            let inner = vector.x / (height * sinf(pitch))
            if inner > 1 || inner < -1 {
                yaw = Float.pi / 2
            } else {
                yaw = asinf(inner)
            }
        }
        return yaw
    }
}
