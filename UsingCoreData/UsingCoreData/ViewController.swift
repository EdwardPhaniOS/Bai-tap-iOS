//
//  ViewController.swift
//  UsingCoreData
//
//  Created by iMac_VTCA on 1/15/20.
//  Copyright © 2020 iMac_VTCA. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadInfo()
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        if firstNameTextField.text?.count == 0 || lastNameTextField.text?.count == 0 {
            return
        }
        
        saveInfo(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!)
    }
    
    @IBAction func updateDidTapped(_ sender: UIButton) {
        updateInfo()
    }
    
    func updateInfo() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        let predicate = NSPredicate(format: "firstName = %@ AND lastName = %@", "person2", "person2")
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        fetchRequest.predicate = predicate
        
        do {
            let persons = try manageContext.fetch(fetchRequest)
        
            let updateObject = persons.first
            updateObject?.setValue("updatedPerson2", forKey: "firstName")
            updateObject?.setValue("updatedPerson2", forKey: "lastName")
            
            appDelegate.saveContext()
            
        } catch {
            print("Fetching data error: \(error)")
        }
    }
    
    func saveInfo(firstName: String, lastName: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let personEntity = NSEntityDescription.entity(forEntityName: "Person", in: manageContext)
        
        let newPerson = NSManagedObject(entity: personEntity!, insertInto: manageContext)
        newPerson.setValue(firstName, forKey: "firstName")
        newPerson.setValue(lastName, forKey: "lastName")
        
        
        appDelegate.saveContext()
    }
    
    func loadInfo() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            let persons = try manageContext.fetch(fetchRequest)
            
            for person in persons {
                let personFirstName = person.value(forKey: "firstName") as? String
                let personLastName = person.value(forKey: "lastName") as? String
                print("\(personFirstName ?? "") -- \(personLastName ?? "")")
            }
            
        } catch {
            print("Fetching data error: \(error)")
        }
    }
    
    @IBAction func deleteButtonDidTapped(_ sender: UIButton) {
        deleteInfo()
    }
    
    func deleteInfo() {
       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        let predicate = NSPredicate(format: "firstName = %@ AND lastName = %@", "person3", "person3")
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        fetchRequest.predicate = predicate
        
        do {
            let persons = try manageContext.fetch(fetchRequest)
            
            if let deleteObject = persons.first {
                manageContext.delete(deleteObject)
            }
            
            
            appDelegate.saveContext()
            
        } catch {
            print("Fetching data error: \(error)")
        }
    }
}

