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

class ListProteinsVC: UIViewController {
    
    var filteredProteins : [String] = []
    var unFilteredProteins : [String] = ["001",
                                         "011",
    "031",
    "041",
    "04G"]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
        print("hello from ListProteinsVC")
        // Do any additional setup after loading the view.
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        
        return searchController.searchBar.text?.isEmpty ?? true
        
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredProteins = unFilteredProteins.filter({( protein : String) -> Bool in
            print(protein.lowercased().contains(searchText.lowercased()))
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
        print("is filtering......")
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
    
    
}
//tutorial from here! https://www.raywenderlich.com/472-uisearchcontroller-tutorial-getting-started still more functionality can be implemented so please //TODO check it out again

extension ListProteinsVC: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
