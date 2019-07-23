//
//  ProteinVisVC.swift
//  proteins
//
//  Created by ANASTASIA on 7/20/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

/* Tutorial:  https://www.raywenderlich.com/2243-scene-kit-tutorial-getting-started
 */

// https://files.rcsb.org/ligands/view/HEM_ideal.pdb
// https://files.rcsb.org/ligands/view/HEM_model.pdb
//https://files.rcsb.org/ligands/view/HEM_model.pdb
// https://projects.intra.42.fr/projects/swifty-proteins/projects_users/1401144

/*
 View: The HTTP/HTTPS response headers to the client are set with: Content-Type: text/plain
 Download: The HTTP/HTTPS response headers to the client are set with: Content-Type: application/octet-stream and Content-Transfer-Encoding: binary.
 */


/*
 
 • Display the ligand model in 3D
 • You must use CPK coloring
 • You should at least represent the ligand using Balls and Sticks model
 • When clicking on an atom display the atom type (C, H, O, etc.)
 • Share your modelisation through a ‘Share‘ button
 • You should be able to ‘play‘ (zoom, rotate...) with the ligand in Scene Kit
 */

import Foundation
import UIKit
import SceneKit

class ProteinVisVC : UIViewController{
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var sceneView: SCNView!
    var protein : String = ""
    
    var modelString : String = ""
    var modelStrings : [String] = []
    
    var atomStrings : [String] = []
    var connectionStrings : [String] = []
    
    var atoms : [Atom] = []
    
    
    var geometryNodeAtom : SCNNode = SCNNode()
    var geometryNodeCon : SCNNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.text = protein
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(share(sender:)))
        getProteinModel()

    }
    
    func sceneSetup() {
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        
        geometryNodeAtom = allAtoms()
        geometryNodeCon = allConnections()
        let geometryNode = SCNNode()
        geometryNode.addChildNode(geometryNodeAtom)
        geometryNode.addChildNode(geometryNodeCon)
        sceneView.scene!.rootNode.addChildNode(geometryNode)
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
}






