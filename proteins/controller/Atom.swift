//
//  Atom.swift
//  proteins
//
//  Created by ANASTASIA on 7/22/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation
import SceneKit
import UIKit

class Atom {
    let x : Float
    let y : Float
    let z : Float
    let element : String
    let sequenceNbr : Int
    
    init(x : Float, y : Float, z : Float, el : String, seqNr : Int){
        self.x = x
        self.y = y
        self.z = z
        self.element = el
        self.sequenceNbr = seqNr
    }
    
    func atomGeometry() -> SCNGeometry {
        let atom = SCNSphere(radius: 0.50)
        switch element {
        case  "C":
            atom.firstMaterial!.diffuse.contents = UIColor.darkGray
            atom.firstMaterial!.specular.contents = UIColor.white
        case  "O":
            atom.firstMaterial!.diffuse.contents = UIColor.red
            atom.firstMaterial!.specular.contents = UIColor.white
        case  "H":
            atom.firstMaterial!.diffuse.contents = UIColor.red
            atom.firstMaterial!.specular.contents = UIColor.white
        case "N":
            atom.firstMaterial!.diffuse.contents = UIColor.blue
            atom.firstMaterial!.specular.contents = UIColor.white
        case "F":
            atom.firstMaterial!.diffuse.contents = UIColor.green
            atom.firstMaterial!.specular.contents = UIColor.white
        default:
            atom.firstMaterial!.diffuse.contents = UIColor(red: 0, green: 0.8588, blue: 0.3725, alpha: 1.0) /* #00db5f */
            atom.firstMaterial!.specular.contents = UIColor(red: 0.8588, green: 0, blue: 0.4275, alpha: 1.0) /* #db006d */
        
        }
        return atom
    }
        
        func position() -> SCNVector3 {
            return SCNVector3Make(self.x, self.y, self.z)
        }
    
    
}
