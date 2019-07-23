//
//  ParseFileExtensionForVisProteinVC.swift
//  proteins
//
//  Created by ANASTASIA on 7/23/19.
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
                
                let unit = connectionCylinderNode(startPoint : firstAtom.position(), endPoint: atomToConnect.position(), color: UIColor.green, radius : 0.08)
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
    
    func checkIfNodeEsists(parent : SCNNode, unit : SCNNode) -> Bool{
        for child in parent.childNodes as [SCNNode] {
            if (child.position.x == unit.position.x && child.position.y == unit.position.y && child.position.z == unit.position.z) {
                //print("Node already exists")
                return true
            }
        }
        return false
    
    }
    
    //https://stackoverflow.com/questions/35002232/draw-scenekit-object-between-two-points
    
    func connectionCylinderNode(startPoint : SCNVector3, endPoint: SCNVector3, color : UIColor, radius : CGFloat) -> SCNNode {
        let vector = SCNVector3Make(endPoint.x - startPoint.x, endPoint.y - startPoint.y, endPoint.z - startPoint.z)
        let height = sqrtf(vector.x*vector.x + vector.y*vector.y + vector.z*vector.z)
        let cylinder = SCNCylinder(radius: radius, height: CGFloat(height))
        cylinder.radialSegmentCount = 4
        cylinder.firstMaterial!.diffuse.contents = color
        let node = SCNNode(geometry: cylinder)
        node.position = SCNVector3Make((startPoint.x + endPoint.x) / 2, (startPoint.y + endPoint.y)/2, (startPoint.z + endPoint.z)/2)
        node.eulerAngles = SCNVector3.lineEulerAngles(vector: vector)
        return node
    }

    func allAtoms() -> SCNNode {
        let atomsNode = SCNNode()
        for atomStr in self.atomStrings {
            let split = atomStr.toSingleSpaceLine().components(separatedBy: " ")
            guard let atom = atomStringParse(split : split) else {
                callErrorWithCustomMessage("No atom was created with line \(atomStr). EMpty node returned")
                return SCNNode()
            }
            atoms.append(atom)
            let unit = SCNNode(geometry: atom.atomGeometry())
            unit.position = atom.position()
            atomsNode.addChildNode(unit)
        }
        print("here we go these are number of atoms=> \(atoms.count)")
        return atomsNode
    }
    
    func atomStringParse(split : [String]) -> Atom? {
        let x : Float = split[6].toFloat()
        let y : Float = split[7].toFloat()
        let z : Float = split[8].toFloat()
        let seqNr : Int = split[1].toInt()
        let elem : String = split[11]
        let atom = Atom(x : x, y : y, z : z, el : elem, seqNr : seqNr)
        return atom
    }
}
