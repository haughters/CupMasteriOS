//
//  PreferencesViewController.swift
//  CupMaster
//
//  Created by Jamie Haughton on 13/04/2017.
//  Copyright © 2017 jhaughton. All rights reserved.
//

import UIKit
import SwiftyJSON

class PreferencesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var coffeeTableView: UITableView!
    
    let url = URL(string:"https://cupmaster.herokuapp.com/coffee/preference")!
    var coffees : [Coffee] = []
    
    override func viewWillAppear(_ animated: Bool) {
        getCurrentCoffees()
    }
    
    private func getCurrentCoffees() {
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                DispatchQueue.main.async() {
                    var jsonArray = JSON(data: data!)
                    
                    let coffeeArray = jsonArray["coffees"]
                    
                    for(_, dict) in coffeeArray {
                        let currentCoffee = Coffee(name: dict["name"].stringValue, preference: dict["preference"].intValue, image: UIImage(named: dict["name"].stringValue)!)
                        
                        self.coffees.append(currentCoffee)
                    }
                    
                    self.coffeeTableView.reloadData()
                    
                }
                
            }
            
        })
        task.resume()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "coffeePreferenceCell", for: indexPath) as? CoffeeTableViewCell else {
            fatalError()
        }
        
        let coffee = coffees[indexPath.row]
        
        // Configure Cell
        cell.coffeeLabel.text = coffee.normaliseName()
        cell.coffeeImage.image = coffee.image
        
        if(coffee.preference == 0) {
            cell.coffeePreference.isEnabled = false
            cell.coffeeSwitch.isOn = false
        } else {
            cell.coffeePreference.selectedSegmentIndex = coffee.preference - 1
        }
        
        return cell
    }
}

struct Coffee {
    var name : String
    var preference : Int
    var image : UIImage
    
    static func normalise(name: String) -> String {
        let coffeeName = name.replacingOccurrences(of: "_", with: " ")
        return coffeeName.capitalized
    }
    
    func normaliseName() -> String {
        let coffeeName = self.name.replacingOccurrences(of: "_", with: " ")
        return coffeeName.capitalized
    }
}

