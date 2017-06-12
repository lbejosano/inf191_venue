//
//  MoviePlayerViewController.swift
//  MoviePlayer
//
//  Created by Victor's Mac on 6/10/17.
//  Copyright © 2017 Victor's Mac. All rights reserved.
//
import AVKit
import AVFoundation
import UIKit

class MoviePlayerViewController: UIViewController {
    
    var filepath : String?
    
    var avViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let avPlayer = AVPlayer(url: URL(string: filepath!)!)
        
        print(avPlayer as Any)
        
        self.avViewController.player = avPlayer
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func PlayPressed(_ sender: UIButton) {
        self.present(self.avViewController, animated: true) {
            self.avViewController.player?.play()
        }
    }

    
    
}
