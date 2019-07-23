//
//  ExtensionsForProteinVisVC.swift
//  proteins
//
//  Created by ANASTASIA on 7/23/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation
import SceneKit
import UIKit

/*
 NOYT SURE WHICH REQUEST TO USE HERE
 guard let firstLetter = protein.first else {
 print("No first letter in protein name")
 return
 }
 print("here we go ", firstLetter)
 
 let str : String = "https://files.rcsb.org/ligands/\(firstLetter)/\(protein)/\(protein)_ideal.pdb".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
 
 
 let str : String = "https://files.rcsb.org/ligands/\(protein[0])/\(protein)/\(protein)_ideal.pdb".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
 
 */

extension ProteinVisVC {
    //to evoke view controller
    func callErrorWithCustomMessage(_ message : String) {
        let alert = UIAlertController(
            title : "Error",
            message : message,
            preferredStyle : UIAlertController.Style.alert
        );
        alert.addAction(UIAlertAction(title: "allright, thank you", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getProteinModel(){
       // let str : String = "https://files.rcsb.org/ligands/view/\(protein)_model.pdb".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        
        let str : String = "https://files.rcsb.org/ligands/\(protein[0])/\(protein)/\(protein)_ideal.pdb".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        guard let urlProtein = URL(string: str) else {
            print("Error in building URL")
            return
        }
        var request = URLRequest(url: urlProtein)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let err = error {
                self.callErrorWithCustomMessage("Some error in request")
                print("error occured \(err)")
                return
            } else if let r = response as? HTTPURLResponse, let d = data {
                
                if (r.statusCode >= 400 && r.statusCode < 500){
                    self.callErrorWithCustomMessage("No element found")
                    self.navigationController?.popViewController(animated: true)
                }
                guard let utf8Text = String(data: d, encoding: .utf8) else {
                    print("no utf8 string")
                    self.callErrorWithCustomMessage("No data for element received")
                    self.navigationController?.popViewController(animated: true)
                    return
                }
                self.modelString = utf8Text
                self.modelStrings = self.modelString.components(separatedBy: "\n")
                for one in self.modelStrings{
                    if (one.hasPrefix("ATOM")){
                        self.atomStrings.append(one)
                    }
                    else if (one.hasPrefix("CONECT")){
                        self.connectionStrings.append(one)
                    }
                    else {
                        print(one)
                    }
                }
                print("we added atoms and bonds")
               // self.printAll()
                self.sceneSetup()
            }
        }
        task.resume()
    }
    
    func printAll()
    {
        for one in atomStrings {
            print("ATOM IS \(one)")
        }
        for one in connectionStrings {
            print("Connections  IS \(one)")
        }
    }
    
    
    //copypaste from Stac Ovrflow
    @objc func share(sender:UIView){
        let image : UIImage = sceneView.snapshot()
        let imageToShare = [image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        self.present(activityViewController, animated: true, completion: nil)

    }
    
}
