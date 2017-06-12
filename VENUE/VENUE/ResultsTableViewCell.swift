//
//  ResultsTableViewCell.swift
//  VENUE
//
//  Created by Max Kirchgesner on 6/10/17.
//  Copyright © 2017 Kay Lab. All rights reserved.
//

import Foundation
import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    var resultablecontrollerdelegate: ResultsTableViewController?
    
    var myButtons = ["Media Client", "Flight Info", "Cabin Controls", "Indirect Lights On", "Indirect Lights Off",
                     "Silent Cabin", "Cabin Wake", "Cabin Sleep", "Dark Cabin", "Watch Airshow", "Watch Blue Ray",
                     "Watch HD", "Theater Blue Ray", "Theater", "Voice Command", "Application Settings"]
    
    var settingsButtons = ["Application Preferences", "About This Application"]
    
    
    @IBOutlet weak var tableLabel: UILabel!
//    @IBOutlet weak var tableButton: UIButton! {
//        didSet {
//            tableButton.layer.cornerRadius = 4
//        }
//    }
    
//    @IBAction func buttonPressed(_ sender: Any) {
//        for button in myButtons {
//            if tableLabel.text == button {
//                resultablecontrollerdelegate?.performSegue(withIdentifier: "backToMain", sender: self)
//            }
//        }
//        for button in settingsButtons {
//            if tableLabel.text == button {
//                resultablecontrollerdelegate?.performSegue(withIdentifier: "toSettings", sender: self)
//            }
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
