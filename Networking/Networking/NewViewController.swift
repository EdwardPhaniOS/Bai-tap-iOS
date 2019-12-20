//
//  NewViewController.swift
//  Networking
//
//  Created by iMac_VTCA on 12/20/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

//https://maps.googleapis.com/maps/api/geocode/json?latlng=10.802184,106.686711&output=json&key=AIzaSyD4S0Qu29xxQsOLCPzGBWacF_2ugvu0QoQ

import UIKit

let API_URL2 = "https://maps.googleapis.com/maps/api/geocode/json?latlng=10.802184,106.686711&output=json&key=AIzaSyD4S0Qu29xxQsOLCPzGBWacF_2ugvu0QoQ"

class NewViewController: UIViewController {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    var arrayResult = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestAPI()
    }
    
    private func requestAPI() {
        
        dataTask?.cancel()
        
        if var urlComponent = URLComponents(string: "https://maps.googleapis.com/maps/api/geocode/json") {
            urlComponent.query = "latlng=10.802184,106.686711&output=json&key=AIzaSyD4S0Qu29xxQsOLCPzGBWacF_2ugvu0QoQ"
            
            guard let url = urlComponent.url else { return }
            
            dataTask = defaultSession.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    do {
                        let jsonDecoder = JSONDecoder()
                        let jsonObject = try jsonDecoder.decode(JSONObject.self, from: data)
                        
                        print( jsonObject.results?.first?.placeID ?? "")
                        print( jsonObject.results?.first?.geometry?.location ?? Location(lat: 0, lng: 0))
                        
                        if let result = jsonObject.results {
                            self.arrayResult = result
                        }
                        
                    } catch {
                        print("Error: \(error)")
                    }
                    
                    print("Success")
                }
            })
            
            dataTask?.resume()
        }
    }
    
}
