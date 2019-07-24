//
//  searchInListExtension.swift
//  proteins
//
//  Created by ANASTASIA on 7/24/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//
import UIKit
import Foundation


extension ListProteinsVC: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

