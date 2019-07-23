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
    
    
     var unFilteredProteins : [String] = []
    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        readFromFile()       
        print("hello from ListProteinsVC")
        // Do any additional setup after loading the view.
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        
        return searchController.searchBar.text?.isEmpty ?? true
        
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
                        self.setUpSearchController()
                        self.tableView.reloadData()
                    }
                }
            }
            task.resume()
        }
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredProteins = unFilteredProteins.filter({( protein : String) -> Bool in
            //print(protein.lowercased().contains(searchText.lowercased()))
            return protein.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func setUpSearchController(){
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func isFiltering() -> Bool {
        //print("is filtering......")
        return searchController.isActive && !searchBarIsEmpty()
    }
}

extension ListProteinsVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredProteins.count
        }
        
        return unFilteredProteins.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let protein : String
        if isFiltering() {
            protein = filteredProteins[indexPath.row]
        } else {
            protein = unFilteredProteins[indexPath.row]
        }
        
        cell.textLabel?.text = protein
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "ShowProtein":
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let protein : String
            if isFiltering() {
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

extension ListProteinsVC: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
