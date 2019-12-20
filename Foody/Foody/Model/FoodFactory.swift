//
//  FoodFactory.swift
//  Foody
//
//  Created by iMac_VTCA on 12/20/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import Foundation

struct FoodFactory {
    
    static func createFood() -> [Food] {
        
        let bread1 = Food(name: "Hamburger", imageName: "bread", distance: 2.5, deliveryTime: 5, dateCreated: Date(), isAvailable: true, discout: 20, category: .bread, relatedImages: ["Sandwich", "Sandwich"])
        let bread2 = Food(name: "Sandwich", imageName: "bread2", distance: 1.2, deliveryTime: 15, dateCreated: Date(), isAvailable: false, discout: nil, category: .bread)
        let noodle = Food(name: "Spageti", imageName: "noodles", distance: 5, deliveryTime: 25, dateCreated: Date(), isAvailable: true, discout: 20, category: .bread)
        let snack = Food(name: "Snack", imageName: "snack", distance: nil, deliveryTime: nil, dateCreated: Date(), isAvailable: true, discout: 20, category: .bread)
        
        return [bread1, bread2, noodle, snack, bread1, bread2, noodle, snack]
    }
}
