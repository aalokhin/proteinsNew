//
//  TableViewExtension.swift
//  proteins
//
//  Created by ANASTASIA on 7/24/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation
import UIKit

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
