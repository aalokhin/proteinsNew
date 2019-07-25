//
//  ListProteinsVC.swift
//  proteins
//
//  Created by Anastasiia ALOKHINA on 7/20/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation
import UIKit
//https://www.raywenderlich.com/472-uisearchcontroller-tutorial-getting-started
//

/* Reading from file localpath */
/* let contents = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
 print(contents) */

class ListProteinsVC: UIViewController {
    
    var filteredProteins : [String] = []
    var unFilteredProteinsTest : [String] = ["001",
                                         "011",
    "031",
    "041",
    "04G"]
    
    var shouldShowSearchResults = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var unFilteredProteins : [String] = []
    
//    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
        
        let nib = UINib.init(nibName: "LigandCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "LigandCell")
        
        readFromFile()       
        print("hello from ListProteinsVC")
    }
    
    @objc func appMovedToBackground() {
        print("App moved to background! from List proteins VC")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
   
    
    
    func readFromFile(){
        /* File is being uploaded from Intra now which actually sucks */
        let path = URL(string: "https://projects.intra.42.fr/uploads/document/document/312/ligands.txt")
        do {
            var request = URLRequest(url: path!)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) {data, response, error in
                if let err = error {
                    print("error occured \(err)")
                    return
                } else if let _ = response as? HTTPURLResponse, let d = data {
                    
                    guard let utf8Text = String(data: d, encoding: .utf8) else {
                        print("no utf8 string")
                        return
                        
                    }
                    // print(utf8Text)
                    self.unFilteredProteins = utf8Text.components(separatedBy: .whitespacesAndNewlines)
                    print("We have this many proteins => ", self.unFilteredProteins.count)
                    DispatchQueue.main.async {
                        self.setUpSearchBar()
                        self.tableView.reloadData()
                    }
                }
            }
            task.resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
/*not using right now but lets leave it for now*/
        case "ShowProtein":
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let protein : String
            if shouldShowSearchResults == true {
                protein = filteredProteins[indexPath.row]
            } else {
                protein = unFilteredProteins[indexPath.row]
            }
            let destination = segue.destination as! ProteinVisVC
            destination.protein = protein
/*not using right now but lets leave it for now*/
        case "FromTableView":
            print("FromTableView")
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let protein : String
            if shouldShowSearchResults == true{
                protein = filteredProteins[indexPath.row]
            } else {
                protein = unFilteredProteins[indexPath.row]
            }
            let destination = segue.destination as! ProteinVisVC
            destination.protein = protein
            
            
        case "addProtein": //TODO
            print("create note bar button item tapped")
        default:
            print("unexpected segue identifier")
        }
    }
}

//tutorial from here! https://www.raywenderlich.com/472-uisearchcontroller-tutorial-getting-started still more functionality can be implemented so please //TODO check it out again
