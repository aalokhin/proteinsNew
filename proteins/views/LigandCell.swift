//
//  LigandCell.swift
//  proteins
//
//  Created by ANASTASIA on 7/24/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation
import UIKit

class LigandCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = UIColor(white: 1, alpha: 0.2)
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
