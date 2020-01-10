//
//  Item.swift
//  TodoList
//
//  Created by iMac_VTCA on 1/10/20.
//  Copyright © 2020 iMac_VTCA. All rights reserved.
//

import Foundation

struct Item: Codable {
    let uuid: String
    var title: String
    var description: String
    var date: Date
}
