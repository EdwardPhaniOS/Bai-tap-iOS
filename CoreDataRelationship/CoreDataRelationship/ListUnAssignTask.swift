//
//  ListUnAssignTask.swift
//  CoreDataRelationship
//
//  Created by Tan Vinh Phan on 2/28/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import UIKit
import CoreData

class ListUnAssignTask: UIViewController {

    //
    //MARK: - Outlets
    //
    @IBOutlet weak var contentTableView: UITableView!
    
    //
    //MARK: - Variables
    //
    private lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    lazy var fetchResultsController: NSFetchedResultsController<NSManagedObject> = {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "status = 0")
        
        let fetchResultsController = NSFetchedResultsController<NSManagedObject>(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTableView.dataSource = self
        contentTableView.delegate = self
        contentTableView.rowHeight = 140
        
        loadAllUnAssignTask()
    }
    
    func loadAllUnAssignTask() {
        
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    @IBAction func doneDidTapped(_ sender: UIBarButtonItem) {
    }
}

//
//MARK: - UITableViewDataSource
//
extension ListUnAssignTask: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = fetchResultsController.sections else { return 0 }
        
        return sections[section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UnAssignTaskCell", for: indexPath) as? UnAssignTaskCell {
            
            guard let task = fetchResultsController.object(at: indexPath) as? Task else {
                return UITableViewCell()
            }
            
            cell.taskIDLabel.text = "\(task.id)"
            cell.taskNameLabel.text = "\(task.name ?? "")"
            
//            cell.delegate = self
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

//
//MARK: - UITableViewDelegate
//
extension ListUnAssignTask: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}

//
//MARK: - NSFetchedResultsControllerDelegate
//
extension ListUnAssignTask: NSFetchedResultsControllerDelegate {
    
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
            
            if let index = indexPath {
                contentTableView.reloadRows(at: [index], with: .fade)
            }
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

