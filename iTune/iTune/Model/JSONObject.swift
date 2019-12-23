//
//  JSONObject.swift
//  iTune
//
//  Created by iMac_VTCA on 12/20/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import Foundation

struct JSONObject: Codable {
    var results: [Track]?
}

struct Track: Codable {
    var artistName: String
    var trackName: String
    var previewUrl: String
    
}

