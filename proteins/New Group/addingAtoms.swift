//
//  ParseFileExtensionForVisProteinVC.swift
//  proteins
//
//  Created by ANASTASIA on 7/23/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//
/* https://github.com/devindazzle/SCNVector3Extensions/blob/master/SCNVector3Extensions.swift */

// https://habr.com/ru/post/131931/
import Foundation
import SceneKit

extension ProteinVisVC {
    
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
            unit.name = atom.element // adds name to an element
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
