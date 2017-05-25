//
//  ResultsTableViewCell.swift
//  venueapp
//
//  Created by Max Kirchgesner on 5/25/17.
//  Copyright © 2017 venue. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
