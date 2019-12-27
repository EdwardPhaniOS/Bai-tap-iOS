//
//  Track.swift
//  NewNetworking
//
//  Created by THAI LE QUANG on 12/23/19.
//  Copyright © 2019 THAI LE QUANG. All rights reserved.
//

import UIKit

struct Track: Codable {
    
    //
    // MARK: - Constants
    //
    let artist: String
    let index: Int
    let name: String
    let previewURL: URL
    
    //
    // MARK: - Variables And Properties
    //
    var downloaded = false
    
    //
    // MARK: - Initialization
    //
    init(name: String, artist: String, previewURL: URL, index: Int) {
        self.name = name
        self.artist = artist
        //      self.previewURL = previewURL
        self.index = index
        
        //TEST
        
        let random = Int.random(in: 10...300)
        
        if random % 2 == 0 {
            self.previewURL = URL(string: "https://www.youtube.com/audiolibrary_download?vid=60281cc96333e210")!
            
        } else {
            self.previewURL = URL(string: "https://www.youtube.com/audiolibrary_download?vid=6722391bde350dc5")!
        }
    }
}
