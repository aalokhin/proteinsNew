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
    
    var bondsNbr : Int = 0
    
    var modelString : String = ""
    var modelStrings : [String] = []
    
    var atomStrings : [String] = []
    var connectionStrings : [String] = []
    
    var atoms : [Atom] = []
    
    let scene = SCNScene()
    var geometryNodeAtom : SCNNode = SCNNode()
    var geometryNodeCon : SCNNode = SCNNode()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //to be able to notify us if the app was moved to background
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        //tapping gesture for a thing
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProteinVisVC.sceneTapped(recognizer:)))
        self.view.addGestureRecognizer(tapGesture)
        
        topLabel.text = protein
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(share(sender:)))
        getProteinModel()

    }
    
    
    @objc func sceneTapped(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: self.sceneView)
        
        let hit = self.sceneView!.hitTest(location, options: nil)
        if let tappedNode = hit.first?.node {
            if let name = tappedNode.name {
                print("node with a name has been tapped ")
                topLabel.text = name
            }
            else {
                 topLabel.text = "no name node"
                print("tapped on a node with no name")
            }
        } else {
             topLabel.text = "no node tapped "
            print("apped elswhere but node")
        }
    }

    @objc func appMovedToBackground() {
        print("App moved to background! from  protein visualization VC")
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
    func sceneSetup() {
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
    
   
}
