//
//  NetworkManager.swift
//  iTune
//
//  Created by iMac_VTCA on 12/20/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import Foundation

let API_URL = "https://itunes.apple.com/search?media=music&entity=song&term=Happynewyear"

protocol NetworkManagerDelegate: class {
    func didUpdateSong(_ networkManager: QueryService, results: [Track])
    func didFailWithError(error: Error)
}

struct QueryService {
    
    var ituneURL: String = "https://itunes.apple.com/search?media=music&entity=song"
    
    var delegate: NetworkManagerDelegate?
    
    func fetchSong(songName: String) {
        
        let urlString = "\(ituneURL)&term=\(songName)"
        print(urlString)
        
        performRequest(with: urlString)
    }
    
    
    //Perform Request from API can't return value imediately => We need to return value in a Closure or a Protocol with a delegate
    
    func performRequest(with urlString: String) {
        
        //create url
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                    
                } else {
                    
                    if let safeData = data {
                        if let tracks = self.parseJSON(safeData) {
                            self.delegate?.didUpdateSong(self, results: tracks)
                        }
                    }
                }
            }
            
            dataTask.resume()
        }
    }
    
    func parseJSON(_ jsonData: Data) -> [Track]? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(JSONObject.self, from: jsonData)
            let results = decodedData.results
            return results
        
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
