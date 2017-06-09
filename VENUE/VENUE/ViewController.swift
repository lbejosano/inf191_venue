//
//  ViewController.swift
//  VENUE
//
//  Created by Kay Lab on 6/7/17.
//  Copyright © 2017 Kay Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Cabin Remote:
    
    @IBOutlet weak var MediaClientButton: UIButton!
    
    @IBOutlet weak var FlightInfoButton: UIButton!
    
    @IBOutlet weak var CabinControlsButton: UIButton!
    
    //Cabin Presets:
    @IBOutlet weak var IndirectLightsOnButton: UIButton!
    

    @IBOutlet weak var IndirectLightsOffButton: UIButton!
    
    @IBOutlet weak var SilentCabinButton: UIButton!
    
    @IBOutlet weak var CabinWakeButton: UIButton!
    
    @IBOutlet weak var CabinSleepButton: UIButton!
    
    @IBOutlet weak var DarkCabinButton: UIButton!
    
    @IBOutlet weak var WatchAirshowButton: UIButton!
    
    @IBOutlet weak var WatchBlueRay1Button: UIButton!
    
    @IBOutlet weak var WatchHD1Button: UIButton!
    
    @IBOutlet weak var TheaterBluRay1Button: UIButton!
    
    @IBOutlet weak var Theater1HDButton: UIButton!
    
    //Footer
    @IBOutlet weak var VoiceCommandButton: UIButton!
    
    @IBOutlet weak var AppSettingsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

