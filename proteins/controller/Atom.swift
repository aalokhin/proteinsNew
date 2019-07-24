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
    
    
    /* https://www.umass.edu/microbio/chime/beta/ben-tal/s180/cpk-rgb.htm */
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
        case "Cl":
            return UIColor(red: 0, green: 1, blue: 0, alpha: 1.0) /* #00ff00 */
        case "B":
             return UIColor(red: 0, green: 1, blue: 0, alpha: 1.0) /* #00ff00 */
 /* Ca, Mn, Al, Ti, Cr, Ag    dark grey        [128,128,144]  80 80 90  */
        case "Ca":
            return UIColor(red: 0.502, green: 0.502, blue: 0.5647, alpha: 1.0) /* #808090 */
        case "Mn":
            return UIColor(red: 0.502, green: 0.502, blue: 0.5647, alpha: 1.0) /* #808090 */
        case "Al":
            return UIColor(red: 0.502, green: 0.502, blue: 0.5647, alpha: 1.0) /* #808090 */
        case "Ti":
            return UIColor(red: 0.502, green: 0.502, blue: 0.5647, alpha: 1.0) /* #808090 */
        case "Cr":
            return UIColor(red: 0.502, green: 0.502, blue: 0.5647, alpha: 1.0) /* #808090 */
        case "Ag":
            return UIColor(red: 0.502, green: 0.502, blue: 0.5647, alpha: 1.0) /* #808090 */
/*     Zn, Cu, Ni, Br            brown            [165,42,42]    A5 2A 2A */
        case "Zn":
            return UIColor(red: 0.6471, green: 0.1647, blue: 0.1647, alpha: 1.0) /* #a52a2a */
        case "Cu":
            return UIColor(red: 0.6471, green: 0.1647, blue: 0.1647, alpha: 1.0) /* #a52a2a */
        case "Ni":
            return UIColor(red: 0.6471, green: 0.1647, blue: 0.1647, alpha: 1.0) /* #a52a2a */
        case "Br":
            return UIColor(red: 0.6471, green: 0.1647, blue: 0.1647, alpha: 1.0) /* #a52a2a */
/*     F, Si, Au                 goldenrod        [218,165,32]   DA A5 20 */
        case "F":
            return UIColor(red: 0.8549, green: 0.6471, blue: 0.1255, alpha: 1.0) /* #daa520 */
        case "Si":
            return UIColor(red: 0.8549, green: 0.6471, blue: 0.1255, alpha: 1.0) /* #daa520 */
        case "Au":
            return UIColor(red: 0.8549, green: 0.6471, blue: 0.1255, alpha: 1.0) /* #daa520 */
/* Iodine                    purple           [160,32.240]   A020F0 */
        case "I":
            return UIColor(red: 0.6275, green: 0.1255, blue: 0.9412, alpha: 1.0) /* #a020f0 */
//            Lithium                   firebrick        [178,34,34]    B22222
        case "Li":
            return UIColor(red: 0.698, green: 0.1333, blue: 0.1333, alpha: 1.0) /* #b22222 */
//            Helium                    pink             [255,192,203]  FFC0CB
        case "He":
            return UIColor(red: 1, green: 0.7529, blue: 0.7961, alpha: 1.0) /* #ffc0cb */
//            Magnesium                 forest green     [34,139,34]    228B22
        case "Mg":
            return UIColor(red: 0.1333, green: 0.5451, blue: 0.1333, alpha: 1.0) /* #228b22 */
//            Phosphorus, Iron, Barium  orange           [255,165,0]    FFA500
        case "P":
            return UIColor(red: 1, green: 0.6471, blue: 0, alpha: 1.0) /* #ffa500 */
        case "Fe":
            return UIColor(red: 1, green: 0.6471, blue: 0, alpha: 1.0) /* #ffa500 */
        case "Ba":
            return UIColor(red: 1, green: 0.6471, blue: 0, alpha: 1.0) /* #ffa500 */
        default:
            return UIColor(red: 1, green: 0.0784, blue: 0.5765, alpha: 1.0) /* #ff1493 */
        }
    }
    
    
}
