//
//  Restaurent.swift
//  Foody
//
//  Created by iMac_VTCA on 12/20/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import Foundation

struct Food {
    var name: String
    var imageName: String
    var distance: Double?
    var deliveryTime: Int?
    var dateCreated: Date
    var isAvailable: Bool
    var discout: Double?
    var category: Category
    var address: String?
    var relatedImages: [String]?
    
    
    enum Category {
        case noodles
        case rice
        case bread
        case snacks
        case fastFood
        case milkTea
        case coffee
        case others
    }
}

