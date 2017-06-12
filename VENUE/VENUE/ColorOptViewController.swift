//
//  ViewController.swift
//  colorOptimization
//
//  Created by Joshua Mitchell on 4/5/17.
//  Copyright © 2017 Joshua Mitchell. All rights reserved.
//

import UIKit


class ColorOptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
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
            let newcell = tableView.dequeueReusableCell(withIdentifier: "slider") as! SliderCell
            newcell.slider.addTarget(self,action: #selector(ColorOptViewController.sliderValueChanged(_:)), for: .valueChanged)
            NotificationCenter.default.addObserver(self, selector: #selector(ColorOptViewController.displayBrightnessChanged(_ :)), name: NSNotification.Name.UIScreenBrightnessDidChange, object: nil)
            return newcell
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ didSelectRowAttableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath)!
        var oldCellIndex = 0
        if indexPath.row < 3 {
            oldCellIndex = unselectCell()
            currentCell.accessoryType = .checkmark
        }
        if indexPath.row == 0 {
            let sliderCell = tableView.cellForRow(at: IndexPath.init(row: 3, section: 0)) as! SliderCell
            UserDefaults.standard.set("dark", forKey: "colorOpt")
            if oldCellIndex == 1
            {
                //change color to dark
                
                darkMode(inView: self.view)
                sliderCell.slider.backgroundColor = UIColor.clear
                tableView.separatorColor = UIColor.white
            }
            else if oldCellIndex == 2 { //remove observer if automatic off
                NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIScreenBrightnessDidChange, object: nil)
                
                sliderCell.slider.removeTarget(self,action: #selector(ColorOptViewController.sliderValueChanged(_:)), for: .valueChanged)
                //then change color to dark
                if self.view.backgroundColor != UIColor.darkGray{
                    darkMode(inView: self.view)
                    sliderCell.slider.backgroundColor = UIColor.clear
                    tableView.separatorColor = UIColor.white
                }
            }
        }
        else if indexPath.row == 1 {
            let sliderCell = tableView.cellForRow(at: IndexPath.init(row: 3, section: 0)) as! SliderCell
            UserDefaults.standard.set("bright", forKey: "colorOpt")
            if oldCellIndex == 0
            {
                //change to brightmode
                brightMode(inView: self.view)
                sliderCell.slider.backgroundColor = UIColor.clear
                self.tableView.separatorColor = UIColor.black
            }
            else if oldCellIndex == 2
            {
                //remove observer
                NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIScreenBrightnessDidChange, object: nil)
                
                sliderCell.slider.removeTarget(self,action: #selector(ColorOptViewController.sliderValueChanged(_:)), for: .valueChanged)
                //switch to brightmode now
                if self.view.backgroundColor != UIColor.white{
                    brightMode(inView: self.view)
                    sliderCell.slider.backgroundColor = UIColor.clear
                    self.tableView.separatorColor = UIColor.black
                }
            }
        }
        else if indexPath.row == 2 {
            UserDefaults.standard.set("automatic", forKey: "colorOpt")
            if oldCellIndex == 0
            {
                NotificationCenter.default.addObserver(self, selector: #selector(ColorOptViewController.displayBrightnessChanged(_ :)), name: NSNotification.Name.UIScreenBrightnessDidChange, object: nil)
                let sliderCell = tableView.cellForRow(at: IndexPath.init(row: 3, section: 0)) as! SliderCell
                sliderCell.slider.addTarget(self,action: #selector(ColorOptViewController.sliderValueChanged(_:)), for: .valueChanged)
                sliderValueChanged(sliderCell.slider)
            }
            else if oldCellIndex == 1
            {
                NotificationCenter.default.addObserver(self, selector: #selector(ColorOptViewController.displayBrightnessChanged(_ :)), name: NSNotification.Name.UIScreenBrightnessDidChange, object: nil)
                let sliderCell = tableView.cellForRow(at: IndexPath.init(row: 3, section: 0)) as! SliderCell
                sliderCell.slider.addTarget(self,action: #selector(ColorOptViewController.sliderValueChanged(_:)), for: .valueChanged)
                sliderValueChanged(sliderCell.slider)
            }
        }
    }
    func unselectCell() -> Int {
        let cells = self.tableView.visibleCells
        var count = 0
        for cell in cells {
            if cell.accessoryType == .checkmark
            {
                cell.accessoryType = .none
                return count
            }
            count += 1
        }
        return count
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.slider_val = CGFloat(sender.value);
        let screen = UIScreen.main
        if screen.brightness > CGFloat(sender.value) {
            if self.view.backgroundColor != UIColor.white
            {
                brightMode(inView: self.view)
                tableView.separatorColor = UIColor.black
            }
        }
            
        else {
            if self.view.backgroundColor != UIColor.darkGray {
                darkMode(inView: self.view)
                tableView.separatorColor = UIColor.white
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        NotificationCenter.default.addObserver(self, selector: #selector(ColorOptViewController.displayBrightnessChanged(_ :)), name: NSNotification.Name.UIScreenBrightnessDidChange, object: nil)
    }
    
    func displayBrightnessChanged(_ notification: Notification){
        let screen = UIScreen.main
        let cell = tableView.cellForRow(at: IndexPath.init(row: 3, section: 0)) as! SliderCell
        if screen.brightness > CGFloat(cell.slider.value) {
            if self.view.backgroundColor != UIColor.white{
                brightMode(inView: self.view)
                
                tableView.separatorColor = UIColor.black
                
            }
        }
        else
        {
            if self.view.backgroundColor != UIColor.darkGray
            {
                darkMode(inView: self.view)
                tableView.separatorColor = UIColor.white
                
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func darkMode(inView: UIView)
    {
        self.view.backgroundColor = UIColor.darkGray
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
    
    func brightMode(inView: UIView)
    {
        view.backgroundColor = UIColor.white
        for subview in inView.subviews
        {
            if let view = subview as? UILabel
            {
                view.textColor = UIColor.black
            }
            else
            {
                subview.backgroundColor = UIColor.white
                self.brightMode(inView: subview)
            }
            
        }
    }
}

