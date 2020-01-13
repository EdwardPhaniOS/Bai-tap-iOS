//
//  ViewController.swift
//  SaveData
//
//  Created by iMac_VTCA on 1/10/20.
//  Copyright © 2020 iMac_VTCA. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.age, forKey: "age")
    }
    
    required init?(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: "name") as? String ?? ""
        self.age = coder.decodeObject(forKey: "age") as? Int ?? 0
    }
}

struct Vehicle: Codable {
    var name: String
    var year: Int
}

class ViewController: UIViewController {
    
    @IBOutlet weak var myTextField: UITextField!
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let value = userDefault.string(forKey: "myText") {
            print(value)
            myTextField.text = value
        }
        
        if let value = userDefault.value(forKey: "myBoolen") as? Bool {
            print(value)
        }
        
        if let value = userDefault.value(forKey: "myInt") as? Int {
            print(value)
        }
        
        if let value = userDefault.value(forKey: "myArray") as? [Int] {
            print(value)
        }
        
        //        if let value = userDefault.object(forKey: "myDict") as? [String : String] {
        //            print(value)
        //        }
        
        if let value = userDefault.value(forKey: "myDict") {
            print(value)
        }
        
        guard let userData = userDefault.object(forKey: "person1") as? Data else { return }
        
        if let person1 = try? NSKeyedUnarchiver.unarchivedObject(ofClass: Person.self, from: userData) {
            
            print(person1.name)
            print(person1.age)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        let text = myTextField.text ?? ""
        
        //        if text == "" {
        //            return
        //        }
        
        userDefault.set(text, forKey: "myText")
        //        userDefault.removeObject(forKey: "myText")
        
        userDefault.set(true, forKey: "myBoolen")
        
        userDefault.set(10, forKey: "myInt")
        
        userDefault.set([1, 2, 3, 4, 5], forKey: "myArray")
        
        let myDict = [
            "1" : "Number 1",
            "2" : "Number 2",
            "3" : "Number 3",
        ]
        
        userDefault.set(myDict, forKey: "myDict")
        
        let person1 = Person(name: "Person 1", age: 24)
        
        do {
            let person1Data = try NSKeyedArchiver.archivedData(withRootObject: person1, requiringSecureCoding: true)
            
            userDefault.set(person1Data, forKey: "person1")
        } catch {
            print("error: \(error)")
        }
        
        let car = Vehicle(name: "BMW", year: 2009)
        let carData = try! JSONEncoder().encode(car)
        
        userDefault.set(carData, forKey: "vehicle")

        if let returnData = userDefault.value(forKey: "vehicle") as? Data {
            let car = try! JSONDecoder().decode(Vehicle.self, from: returnData)
            print(car)
        }
    }
    
}


