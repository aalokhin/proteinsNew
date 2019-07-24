//
//  TableViewExtension.swift
//  proteins
//
//  Created by ANASTASIA on 7/24/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation
import UIKit

extension ListProteinsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults == true  {
            return filteredProteins.count
        }
        return unFilteredProteins.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.performSegue(withIdentifier: "FromTableView", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LigandCell", for: indexPath) as! LigandCell
        let protein : String
        if shouldShowSearchResults == true {
            protein = filteredProteins[indexPath.row]
        } else {
            protein = unFilteredProteins[indexPath.row]
        }
        cell.nameLbl.text = protein
        return cell
    }
    
}
