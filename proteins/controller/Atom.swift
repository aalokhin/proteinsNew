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
        //print(seqNr)
        self.x = x
        self.y = y
        self.z = z
        self.element = el
        self.sequenceNbr = seqNr
    }
    
    func atomGeometry() -> SCNGeometry {
        let atom = SCNSphere(radius: 0.3)
        atom.firstMaterial!.diffuse.contents = getCPKColor(el : element)
        atom.firstMaterial!.specular.contents = UIColor.white
        return atom
    }
        
    func position() -> SCNVector3 {
        return SCNVector3Make(self.x, self.y, self.z)
    }
    
    func getCPKColor(el : String) -> UIColor {
        switch el {
        case "C":
            return UIColor(red: 0.7843, green: 0.7843, blue: 0.7843, alpha: 1.0) /* #c8c8c8 */
        case "O":
            return UIColor(red: 0.9412, green: 0, blue: 0, alpha: 1.0) /* #f00000 */
        case "H":
            return UIColor(red: 1, green: 1, blue: 1, alpha: 1.0) /* #ffffff */
        case "N":
            return UIColor(red: 0.5608, green: 0.5608, blue: 1, alpha: 1.0) /* #8f8fff */
        case "S":
            return UIColor(red: 1, green: 0.7843, blue: 0.1961, alpha: 1.0) /* #ffc832 */
        case "Na":
            return UIColor(red: 0, green: 0, blue: 1, alpha: 1.0) /* #0000ff */
         default:
            return UIColor(red: 1, green: 0.0784, blue: 0.5765, alpha: 1.0) /* #ff1493 */
        }
    }
    
    
}
