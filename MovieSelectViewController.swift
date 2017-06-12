//
//  ViewController.swift
//  MoviePlayer
//
//  Created by Victor's Mac on 6/10/17.
//  Copyright © 2017 Victor's Mac. All rights reserved.
//
import Foundation
import UIKit

class MovieSelectViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "PlayPressed" {
            
            let filepath = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
            if let destinationViewController = segue.destination as? MoviePlayerViewController{
                if(filepath.isEmpty == false)
                {
                    destinationViewController.filepath = filepath as String
                }
                }
            }
    }


}

