//
//  ProteinVisVC.swift
//  proteins
//
//  Created by ANASTASIA on 7/20/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation
import UIKit

class ProteinVisVC : UIViewController{
    
    var protein : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ProteinVisVC :our protein is  \(protein)")
        getProteinModel()
        // Do any additional setup after loading the view.
    }
    
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
                
                print(" our response code is \(r.statusCode)")
//                print(data)
//                Dispa
   
                
                
                let urlContent = NSString(data: d, encoding: String.Encoding.utf8.rawValue)
                print(urlContent)
                /*********************************** it's not json that we receive ******************
                let json = try? JSONSerialization.jsonObject(with: d, options: [])
                print(json ?? "nothing was serialized") ***/
            }
        }
        task.resume()
    }
    
    
    //https://files.rcsb.org/ligands/view/HEM_ideal.pdb
    //https://files.rcsb.org/ligands/view/HEM_model.pdb
    //https://projects.intra.42.fr/projects/swifty-proteins/projects_users/1401144
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
}
