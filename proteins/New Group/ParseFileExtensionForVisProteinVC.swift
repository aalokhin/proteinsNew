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
                connectionsNode.addChildNode(unit)
                i+=1
            }
        }
        print()
        return connectionsNode
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
