//
//  Address.swift
//  Networking
//
//  Created by iMac_VTCA on 12/20/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import Foundation

struct JSONObject: Codable {
    var results: [Result]?
}

struct Result: Codable {
    var placeID: String?
    var geometry: Geometry?
    
    private enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case geometry
    }
}

struct Geometry: Codable {
    var location: Location?
}

struct Location: Codable {
    var lat: Double
    var lng: Double
}
