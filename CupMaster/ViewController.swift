//
//  ViewController.swift
//  CupMaster
//
//  Created by Jamie Haughton on 10/04/2017.
//  Copyright (c) 2017 jhaughton. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var coffeeName : UILabel!
    @IBOutlet weak var coffeeImage: UIImageView!
    
    let url = URL(string: "https://cupmaster.herokuapp.com/coffee/choose")!
    let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        toggleLabels(hidden: true)
        initializeActivityIndicator()
    }

    @IBAction func getCoffeeChoice(_ sender: UIButton) {
        toggleLabels(hidden: true)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()

        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {

                DispatchQueue.main.async() {
                    var chosenCoffee = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
                    chosenCoffee = chosenCoffee.replacingOccurrences(of: "\"", with: "")

                    self.coffeeImage.image = UIImage(named: chosenCoffee)
                    
                    self.coffeeName.text = Coffee.normalise(name: chosenCoffee)
                    
                    self.toggleLabels(hidden: false)
                }
                
            }
            
        })
        task.resume()
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    private func toggleLabels(hidden : Bool) {
        coffeeName.isHidden = hidden
        coffeeImage.isHidden = hidden
        header.isHidden = hidden
    }
    
    private func initializeActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        view.bringSubview(toFront: activityIndicator)
    }


}
