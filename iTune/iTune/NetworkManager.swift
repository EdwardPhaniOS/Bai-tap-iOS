//
//  NetworkManager.swift
//  iTune
//
//  Created by iMac_VTCA on 12/20/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import Foundation

class NetworkManager {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func requestAPI() -> [Track] {
        let tracks = [Track]()
        
        self.dataTask?.cancel()
        
        if let data = stringJSON.data(using: .utf8) {
            
            do {
                
                let jsonDecoder = JSONDecoder()
                let jsonObject = try jsonDecoder.decode(JSONObject.self, from: data)
                
                if let tracks = jsonObject.results {
                    return tracks
                }
               
            } catch {
                print("Error: \(error)")
            }
        }
        
        return tracks
    }
    
    
    
}
