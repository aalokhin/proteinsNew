//
//  searchInListExtension.swift
//  proteins
//
//  Created by ANASTASIA on 7/24/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//
import UIKit
import Foundation


//from here : https://www.youtube.com/watch?v=8xf-NztULEY

extension ListProteinsVC: UISearchBarDelegate {
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        print("here")
        return searchBar.text?.isEmpty ?? true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredProteins = unFilteredProteins.filter({( protein : String) -> Bool in
            return protein.lowercased().contains(searchText.lowercased())
        })
        shouldShowSearchResults = searchText != "" ? true : false
        tableView.reloadData()
    }
    
    func setUpSearchBar(){
        searchBar.delegate = self
    }
}

