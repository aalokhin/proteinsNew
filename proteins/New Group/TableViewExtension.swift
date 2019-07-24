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
    
//    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//       print("xs")
//        self.performSegue(withIdentifier: "FromTableView", sender: self)
//
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.performSegue(withIdentifier: "FromTableView", sender: self)
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let indexPath = tableView.indexPathForSelectedRow;
//        let cellname = tableView.cellForRowAtIndexPath(indexPath!) as! CardTableViewCell;
//        let DetailViewController = segue.destinationViewController
//        DetailViewController.title = cellname.textLabel?.text
//    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LigandCell", for: indexPath) as! LigandCell
        let protein : String
        if isFiltering() {
            protein = filteredProteins[indexPath.row]
        } else {
            protein = unFilteredProteins[indexPath.row]
        }
        //cell.textLabel?.text = protein
        cell.nameLbl.text = protein
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
        case "FromTableView":
            print("FromTableView")
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
