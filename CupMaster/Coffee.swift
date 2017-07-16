//
//  Coffee.swift
//  CupMaster
//
//  Created by Jamie Haughton on 13/04/2017.
//  Copyright © 2017 jhaughton. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Coffee {
    var name : String
    var preference : Int
    var image : UIImage
}

//class Coffee : NSObject {
//    
//    var name : String?
//    var preference : Int?
//    var image : UIImage?
//    
////    override init() {
////        super.init()
////        
////        guard let coffeeImage = UIImage(named: self.name) else {
////            fatalError()
////        }
////        
////        self.image = coffeeImage
////    }
//}

extension NSObject{
    convenience init(jsonStr:String) {
        self.init()
        if let jsonData = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false)
        {
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
                
                
                // Loop
                for (key, value) in json {
                    let keyName = key as String
                    let keyValue: String = value as! String
                    
                    // If property exists
                    if (self.responds(to: NSSelectorFromString(keyName))) {
                        self.setValue(keyValue, forKey: keyName)
                    }
                }
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        else
        {
            print("json is of wrong format!")
        }
    }
}
