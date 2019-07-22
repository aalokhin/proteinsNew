//
//  ProteinVisVC.swift
//  proteins
//
//  Created by ANASTASIA on 7/20/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

/* Tutorial:  https://www.raywenderlich.com/2243-scene-kit-tutorial-getting-started
 */


/*
 View: The HTTP/HTTPS response headers to the client are set with: Content-Type: text/plain
 Download: The HTTP/HTTPS response headers to the client are set with: Content-Type: application/octet-stream and Content-Transfer-Encoding: binary.
 */


import Foundation
import UIKit
import SceneKit

class ProteinVisVC : UIViewController{
    
    @IBOutlet weak var sceneView: SCNView!
    
    
    
    var protein : String = ""
    var modelString : String = ""
    var modelStrings : [String] = []
    var atoms : [String] = []
    var connections : [String] = []
    
    var geometryNode: SCNNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(share(sender:)))
        getProteinModel()
        
        // Do any additional setup after loading the view.
    }
    
  
    func sceneSetup() {

        let scene = SCNScene()

        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        
        geometryNode = allAtoms()

        
        sceneView.scene!.rootNode.addChildNode(geometryNode)
        
        
    }
    
    func carbonAtom() -> SCNGeometry {
        let carbonAtom = SCNSphere(radius: 0.50)
        carbonAtom.firstMaterial!.diffuse.contents = UIColor(red: 0, green: 0.8588, blue: 0.3725, alpha: 1.0) /* #00db5f */
        carbonAtom.firstMaterial!.specular.contents = UIColor(red: 0.8588, green: 0, blue: 0.4275, alpha: 1.0) /* #db006d */
        return carbonAtom
    }
    
    func allAtoms() -> SCNNode {
        let atomsNode = SCNNode()
        for atom in self.atoms {
          //  let trimmed = atom.componentsSeparatedBy(" ").filter { !$0.isEmpty }.joinWithSeparator(" ")\
            
//           let new = atom.components(separatedBy: " ").filter { !$0.isEmpty }.joined(separator: " ")
           
            
            let split = atom.toSingleSpaceLine().components(separatedBy: " ")
            
           // print(">\(new)<") // >Simple text with spaces<
            
          //  print( split)
            let x : Float = split[6].toFloat()
            let y : Float = split[7].toFloat()
            let z : Float = split[8].toFloat()
           
            
            let unit = SCNNode(geometry: carbonAtom())
            unit.position = SCNVector3Make(x, y, z)
            atomsNode.addChildNode(unit)
        }
        return atomsNode
    }
    
    
    
}


extension ProteinVisVC {
    
    func callErrorWithCustomMessage(_ message : String) {
        
        let alert = UIAlertController(
            title : "Error",
            message : message,
            preferredStyle : UIAlertController.Style.alert
        );
        alert.addAction(UIAlertAction(title: "allright, thank you", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // https://files.rcsb.org/ligands/view/HEM_ideal.pdb
    // https://files.rcsb.org/ligands/view/HEM_model.pdb
    // https://projects.intra.42.fr/projects/swifty-proteins/projects_users/1401144
    
    func getProteinModel(){
        let str : String = "https://files.rcsb.org/ligands/view/\(protein)_model.pdb".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        guard let urlProtein = URL(string: str) else {
            print("Error in building URL")
            return
        }
        
        var request = URLRequest(url: urlProtein)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let err = error {
                print("error occured \(err)")
                return
            } else if let r = response as? HTTPURLResponse, let d = data {
                
                //  print(" our response code is \(r.statusCode)")
                
                
                guard let utf8Text = String(data: d, encoding: .utf8) else {
                    print("no utf8 string")
                    return
                    
                }
                self.modelString = utf8Text
                self.modelStrings = self.modelString.components(separatedBy: "\n")
//                for one in self.modelStrings{
//                    print("{\(one)}")
//                }
                
                for one in self.modelStrings{
                    if (one.hasPrefix("ATOM")){
                       // print("has  atom ")
                        self.atoms.append(one)
                    }
                    else if (one.hasPrefix("CONECT")){
                         //print("has  connection ")
                        self.connections.append(one)
                    }
                    else{
                        print(one)
                    }
                }
                self.printAll()
                self.sceneSetup()
                
                
                // print(self.modelString)
                
            }
        }
        task.resume()
    }
    
    func printAll()
    {
        for one in atoms {
            print("ATOM IS \(one)")
        }
        for one in connections {
            print("Connections  IS \(one)")
        }
        
    }
   //plagiat from Stac Ovrflow
    @objc func share(sender:UIView){
        let image : UIImage = sceneView.snapshot()
        
        let imageToShare = [image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
       // activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
        
//        let message = "Message goes here."
//        //Set the link to share.
//        if let link = NSURL(string: "http://intra.42.fr")
//        {
//            let objectsToShare = [message,link] as [Any]
//            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
//            self.present(activityVC, animated: true, completion: nil)
//        }
        
    }
    
}

