//
//  ViewController.swift
//  colorOptimization
//
//  Created by Joshua Mitchell on 4/5/17.
//  Copyright © 2017 Joshua Mitchell. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let num  = indexPath.row
        var cell:UITableViewCell!
        switch num {
        case 0:
            
            cell = self.tableView.dequeueReusableCell(withIdentifier: "darkModeOn")
            break
        case 1:
            cell = self.tableView.dequeueReusableCell(withIdentifier: "darkModeOff")
            break
        case 2:

            cell = self.tableView.dequeueReusableCell(withIdentifier: "automatic")
            break
        case 3:
            cell = self.tableView.dequeueReusableCell(withIdentifier: "slider") as! SliderCell
            break
        default:
            break
        }

    return cell
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        //update the value of threshold here
        //var thresholdVal = Int(sender.value)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.displayBrightnessChanged(_ :)), name: NSNotification.Name.UIScreenBrightnessDidChange, object: nil)
        
        
    }
    func displayBrightnessChanged(_ notification: Notification){
        let screen = UIScreen.main
        if screen.brightness > 0.5 {
            self.view.backgroundColor = UIColor.white
            brightMode(inView: self.view)
            }
    
        else {
            self.view.backgroundColor = UIColor.darkGray
            darkMode(inView: self.view)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func darkMode(inView: UIView)
    {
        for subview in inView.subviews {
            if let view = subview as? UILabel {
                view.textColor = UIColor.white
            }
            else{
            subview.backgroundColor = UIColor.darkGray
                self.darkMode(inView: subview)
            }
        }
    }
    
    func brightMode(inView: UIView) {
        for subview in inView.subviews {
        if let view = subview as? UILabel {
            view.textColor = UIColor.black
        }
        else{
        subview.backgroundColor = UIColor.white
        self.brightMode(inView: subview)
        }
    }
}

}
