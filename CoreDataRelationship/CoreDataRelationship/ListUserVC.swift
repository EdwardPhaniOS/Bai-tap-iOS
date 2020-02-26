//
//  ListUserVC.swift
//  CoreDataRelationship
//
//  Created by Tan Vinh Phan on 2/26/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import UIKit
import CoreData

class ListUserVC: UIViewController {

    //
    //MARK: - Outlets
    //
    @IBOutlet weak var contentTableView: UITableView!
    
    //
    //MARK: - Variables
    //
    private lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private let addUserAlert = UIAlertController(title: "Add User", message: nil, preferredStyle: .alert)
    
    //TODO: Tách fetchResultsController thành 1 file, file đó chuyên tạo fetchResultsController cho mỗi View Controller
    
    //fetchResultsController = data source cho tableView.dataSource (datasource của datasource)
    lazy var fetchResultsController: NSFetchedResultsController<NSManagedObject> = {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchResultsController = NSFetchedResultsController<NSManagedObject>(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTableView.dataSource = self
        contentTableView.delegate = self
        contentTableView.rowHeight = 140
        
        setUpAlert()
        
        loadAllUser()
    }
    
    func setUpAlert() {
        
        var idTextField = UITextField()
        var firstNameTextField = UITextField()
        var lastNameTextField = UITextField()
        
        addUserAlert.addTextField { (id) in
            id.placeholder = "id"
            id.keyboardType = .numberPad
            idTextField = id
        }
        
        addUserAlert.addTextField { (firstName) in
            firstName.placeholder = "First name"
            firstNameTextField = firstName
        }
        
        addUserAlert.addTextField { (lastName) in
            lastName.placeholder = "Last Name"
            lastNameTextField = lastName
        }
        
        let addUserAction = UIAlertAction(title: "Add", style: .default) { (addAction) in
            
            if idTextField.text?.count != 0
                && firstNameTextField.text?.count != 0
                && lastNameTextField.text?.count != 0 {
                
                let context = self.appDelegate.persistentContainer.viewContext
                
                let newUser = User(context: context)
                
                //TODO: tách thành hàm save()
                
                newUser.id = Int16(idTextField.text!) ?? 0
                newUser.firstName = firstNameTextField.text!
                newUser.lastName = lastNameTextField.text!
                newUser.task = []
                
                self.appDelegate.saveContext()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        addUserAlert.addAction(addUserAction)
        addUserAlert.addAction(cancelAction)
    }
    
    func loadAllUser() {
        
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        self.present(addUserAlert, animated: true, completion: nil)
    }
    
}

extension ListUserVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = fetchResultsController.sections else { return 0 }
        
        return sections[section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell {
            
            guard let user = fetchResultsController.object(at: indexPath) as? User else {
                return UITableViewCell()
            }
            
            cell.fullNameLabel.text = "\(user.lastName ?? "") \(user.firstName ?? "")"
            cell.idLabel.text = "\(user.id)"
            cell.numberOfTaksLabel.text = "\(user.task?.count ?? 0)"
            
            cell.delegate = self
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

//
//MARK: - UITableViewDelegate
//
extension ListUserVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//
//MARK: - UserCellDelegate
//
extension ListUserVC: UserCellDelegate {
    func remove(at cell: UserCell) {
        
        if let index = contentTableView.indexPath(for: cell) {
            
            guard let user = fetchResultsController.object(at: index) as? User else {
                return
            }
            
            //TODO: Tách thành hàm delete()
            
            let manageContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<User>(entityName: "User")
            let idPredicate = NSPredicate(format: "id = %i", user.id)
            fetchRequest.predicate = idPredicate
            
            do {
                let deleteUsers = try manageContext.fetch(fetchRequest)
                
                for user in deleteUsers {
                    manageContext.delete(user)
                }
                
            } catch {
                print("load All User Error: \(error.localizedDescription)")
            }
        }
    }
}


//
//MARK: - NSFetchedResultsControllerDelegate
//
extension ListUserVC: NSFetchedResultsControllerDelegate {
    
    //Run each time context change
    //Ba ham sau tu dong chay ham nay khi context.save/ context.delete/.. duoc goi

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        contentTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            
            if let newIndex = newIndexPath {
                contentTableView.insertRows(at: [newIndex], with: .fade)
            }
            
        case .delete:
            
            if let index = indexPath {
                contentTableView.deleteRows(at: [index], with: .fade)
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
        contentTableView.endUpdates()
    }
}
