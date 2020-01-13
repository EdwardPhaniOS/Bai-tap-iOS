//
//  ViewController.swift
//  SQLite
//
//  Created by iMac_VTCA on 1/13/20.
//  Copyright © 2020 iMac_VTCA. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    
    var db: OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("myDataBase.db") else {
            return
        }
        print(fileURL)
        
        //open db
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return
        }
        
        //create table
        
        let createStatement = "CREATE TABLE IF NOT EXISTS User (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)"
        
        if sqlite3_exec(db, createStatement, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error creating table: \(errmsg)")
            return
        }
    }
    
    @IBAction func addButton_pressed(_ sender: UIButton) {
        var stmt: OpaquePointer?
        
        //query
        let queryString = "INSERT INTO USER (name, age) VALUES (?,?)"
        
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error creating table: \(errmsg)")
            return
        }
        
        let name: NSString = "ANC"
        let age = 10
        
        //smtm: cho chua cua so dang lam viec
        //1, 2...: vi tri index tren bang du lieu
        if sqlite3_bind_text(stmt, 1, name.utf8String, -1, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("failure binding name: \(errmsg)")
        }
        
        if sqlite3_bind_int(stmt, 2, Int32(age)) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("failure binding age: \(errmsg)")
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("failure insert: \(errmsg)")
        }
    }
    
}

