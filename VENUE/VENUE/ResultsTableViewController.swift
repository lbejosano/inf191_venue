//
//  ResultsTableViewController.swift
//  VENUE
//
//  Created by Max Kirchgesner on 6/10/17.
//  Copyright © 2017 Kay Lab. All rights reserved.
//

import Foundation
import UIKit

class ResultsTableViewController: UITableViewController {
    var homebuttons = [String](arrayLiteral: "Media Client","Flight Info","Cabin Controls","Indirect Lights On",
                               "Indirect Lights Off","Silent Cabin","Cabin Wake","Cabin Sleep",
                               "Dark Cabin","Watch Airshow","Watch Blue Ray","Watch HD",
                               "Theater Blue Ray","Theater 1","Voice Command","Application Settings")
    var settingsButtons = ["Application Preferences", "About This Application"]

    
    var text: String?
    var results = [Result?]()
    var buttons = [String?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadResults()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellidentifier = "ResultsTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier, for: indexPath) as! ResultsTableViewCell
        let result = results[(indexPath as NSIndexPath).row]
        cell.tableLabel.text = result?.label
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)! as! ResultsTableViewCell
        
        for button in homebuttons {
            if currentCell.tableLabel.text == button {
                self.performSegue(withIdentifier: "backToMain", sender: self)
            }
        }
        
        for button in settingsButtons {
            if currentCell.tableLabel.text == button {
                self.performSegue(withIdentifier: "toSettings", sender: self)
            }
        }
        
    }
    
    func loadResults() {
        let stringArray = text?.components(separatedBy: " ")
        for button in homebuttons {
            for item in stringArray!{
                if button.contains(item) {
                    results += [Result(label: button)]
                }
            }
        }
        for button in settingsButtons {
            for item in stringArray!{
                if button.contains(item) {
                    results += [Result(label: button)]
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToMain" {
            if let destinationViewController = segue.destination as? voiceCommandController {
                destinationViewController.voicebuttons = homebuttons
            }
        } 
    }
}

