//
//  ViewController.swift
//  CoreDataProject
//
//  Created by Tan Vinh Phan on 2/24/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    //
    //MARK: - Outlets
    //
    @IBOutlet weak var myTableView: UITableView!
    
    //
    //MARK: - Variables
    //
    private lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    lazy var fetchResultsController: NSFetchedResultsController<NSManagedObject> = {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController<NSManagedObject>(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }()
    
    let addPersonAlert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
    
    let deletePersonAlert = UIAlertController(title: "Delete Person", message: nil, preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
//        fetchDataFromCoreData()
        
        setUpAddPersonAlert()
        setUpDeletePersonAlert()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadAllPerson()
    }
    
    func loadAllPerson() {
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    func setUpAddPersonAlert() {
        var nameTextField = UITextField()
        var ageTextField = UITextField()
        ageTextField.keyboardType = .numberPad
        
        addPersonAlert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Name"
            nameTextField = alertTextField
        }
        
        addPersonAlert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Age"
            ageTextField = alertTextField
        }
        
        let addPersonAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if nameTextField.text?.count != 0 && ageTextField.text?.count != 0 {
                
                let name = nameTextField.text!
                let age = Int16(ageTextField.text!) ?? 0
                
                self.save(name: name, age: age)
                
//                self.fetchDataFromCoreData()
                
                self.myTableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        addPersonAlert.addAction(addPersonAction)
        addPersonAlert.addAction(cancelAction)
    }
    
    func setUpDeletePersonAlert() {
        var nameTextField = UITextField()
        var ageTextField = UITextField()
        ageTextField.keyboardType = .numberPad
        
        deletePersonAlert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Name"
            nameTextField = alertTextField
        }
        
        deletePersonAlert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Age"
            ageTextField = alertTextField
        }
        
        let deletePersonAction = UIAlertAction(title: "Delete", style: .default) { (action) in
            
            if ageTextField.text?.count != 0 {
                
                if let age = Int16(ageTextField.text ?? "0") {
                    self.delete(age: age)
                }
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        deletePersonAlert.addAction(deletePersonAction)
        deletePersonAlert.addAction(cancelAction)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        self.present(addPersonAlert, animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        self.present(deletePersonAlert, animated: true, completion: nil)
    }
    
    
    //
    //MARK: - Delete or Add New Item To Core Data
    //
    func save(name: String, age: Int16) {
        
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Person", in: context) else { return }
        
        let newPerson = NSManagedObject(entity: entity, insertInto: context)
        
        newPerson.setValue(name, forKey: "name")
        newPerson.setValue(age, forKey: "age")
        
        
        appDelegate.saveContext()
    }
    
    func updatePersonInfo(name: String, age: Int16, person: NSManagedObject) {
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let nameOld = person.value(forKey: "name") as? String ?? ""
        let ageOld = person.value(forKey: "age") as? Int16 ?? 0
        
        let predicate = NSPredicate(format: "name = %@ AND age = %i", nameOld, ageOld)
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        fetchRequest.predicate = predicate
        
        do {
            let persons = try manageContext.fetch(fetchRequest)
            
            for updateObject in persons {
                updateObject.setValue(name, forKey: "name")
                updateObject.setValue(age, forKey: "age")
            }
            
            appDelegate.saveContext()
            
        } catch {
            print("Error updatePersonInfo: \(error.localizedDescription)")
        }
    }
    
    func delete(age: Int16) {
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let predicate = NSPredicate(format: "age = %i", age)
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        fetchRequest.predicate = predicate
        
        do {
            let persons = try manageContext.fetch(fetchRequest)
            
            for person in persons {
                manageContext.delete(person)
                appDelegate.saveContext()
            }
            
        } catch {
            print("Error with delete info: \(error.localizedDescription)")
        }
        
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = fetchResultsController.sections else {
            return 0
        }
        
        let sectionInfo = sections[section]
        
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? MyCell {
            
            let person = fetchResultsController.object(at: indexPath)
            
            let name = person.value(forKey: "name") as? String ?? ""
            let age =  person.value(forKey: "age") as? Int16 ?? 0
            
            cell.nameLabel.text = name
            cell.ageLabel.text = "\(age)"
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: NSFetchedResultsControllerDelegate {
 
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        myTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            print("insert")
            if let indexPath = newIndexPath {
                myTableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            print("delete")
            if let indexPath = indexPath {
                myTableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            print("update")
        case .move:
            print("move")
        default:
            print("default")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        myTableView.endUpdates()
    }
}
