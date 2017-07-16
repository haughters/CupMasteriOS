//
//  CoffeeTableViewCell.swift
//  CupMaster
//
//  Created by Jamie Haughton on 17/04/2017.
//  Copyright © 2017 jhaughton. All rights reserved.
//

import UIKit

class CoffeeTableViewCell : UITableViewCell {
    
    @IBOutlet weak var coffeePreference: UISegmentedControl!
    @IBOutlet weak var coffeeLabel: UILabel!
    @IBOutlet weak var coffeeImage: UIImageView!
    @IBOutlet weak var coffeeSwitch: UISwitch!
    
    var cellAltered = false
    
    @IBAction func toggleCoffee(_ sender: UISwitch) {
        togglePreferences(switchSetting: coffeeSwitch.isOn)
        cellAltered = true
    }
    
    @IBAction func preferencesChanged(_ sender: UISegmentedControl) {
        cellAltered = true
    }
    
    private func togglePreferences(switchSetting : Bool) {
        coffeePreference.isEnabled = switchSetting
    }
}
