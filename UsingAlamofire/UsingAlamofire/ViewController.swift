//
//  ViewController.swift
//  UsingAlamofire
//
//  Created by iMac_VTCA on 1/3/20.
//  Copyright © 2020 iMac_VTCA. All rights reserved.
//

//https://maps.googleapis.com/maps/api/geocode/json?latlng=10.802184,106.686711&output=json&key=AIzaSyD4S0Qu29xxQsOLCPzGBWacF_2ugvu0QoQ

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AF.request("https://maps.googleapis.com/maps/api/geocode/json?latlng=10.802184,106.686711&output=json&key=AIzaSyD4S0Qu29xxQsOLCPzGBWacF_2ugvu0QoQ").response { (response) in
            
            if let error = response.error {
                print("Requesting data failed: \(error)")
            
            } else if let data = response.data {
                
                var dictionary: [String : Any]?
                
                do {
                    dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
                } catch {
                    print("JSONSerialization failed: \(error.localizedDescription)")
                }
                
                if let results = dictionary?["results"] as? [Any] {
                    
                    for result in results {
                        
                        if let result = result as? [String : Any],
                            let placeId = result["place_id"] as? String {
                            print(placeId)
                        }
                    }
                    
                }
            }
        }
    }


}

