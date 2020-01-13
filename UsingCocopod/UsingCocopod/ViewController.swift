//
//  ViewController.swift
//  UsingCocopod
//
//  Created by iMac_VTCA on 1/3/20.
//  Copyright © 2020 iMac_VTCA. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        AF.request("https://itunes.apple.com/search/media=music&entity=song&term=HappyNewYear").responseJSON { (response) in
            print(response)
            
            if let error = response.error {
                print(error.localizedDescription)
            
            } else if let data = response.data {
                
                var dictionary: [String : Any]?
                
                do {
                    dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                } catch {
                    print("Error with JSONSerialization: \(error.localizedDescription)")
                }
                
                guard let array = dictionary?["results"] as? [Any] else {
                    print("Dictionary does not contain results key\n")
                    return
                    
                }
                
                for trackDict in array {
                    if let trackDictionary = trackDict as? [String : Any],
                        let previewURL = trackDictionary["previewUrl"] as? String {
                        print(previewURL)
                    }
                }
            }
        }
    }


}

