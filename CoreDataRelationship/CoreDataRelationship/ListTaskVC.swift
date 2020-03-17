//
//  ListTaskVC.swift
//  CoreDataRelationship
//
//  Created by Tan Vinh Phan on 2/28/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import UIKit
import CoreData

class ListTaskVC: UIViewController {
    
    //
    //MARK: - Outlets
    //
    @IBOutlet weak var contentTableView: UITableView!
    
    //
    //MARK: - Variables
    //
    private lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private let addTaskAlert = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
    
    lazy var fetchResultsController: NSFetchedResultsController<NSManagedObject> = {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchResultsController = NSFetchedResultsController<NSManagedObject>(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        contentTableView.dataSource = self
        contentTableView.delegate = self
        contentTableView.rowHeight = 140
        
        setUpAlert()
        
        loadAllTask()
    }
    
    func setUpAlert() {
        
        var idTextField = UITextField()
        var nameTextField = UITextField()
        var taskDetailTextField = UITextField()
        
        addTaskAlert.addTextField { (id) in
            id.placeholder = "id"
            id.keyboardType = .numberPad
            idTextField = id
        }
        
        addTaskAlert.addTextField { (name) in
            name.placeholder = "Task name"
            nameTextField = name
        }
        
        addTaskAlert.addTextField { (taskDetail) in
            taskDetail.placeholder = "Task detail"
            taskDetailTextField = taskDetail
        }
        
        let addUserAction = UIAlertAction(title: "Add", style: .default) { (addAction) in
            
            if idTextField.text?.count != 0
                && nameTextField.text?.count != 0
                && taskDetailTextField.text?.count != 0 {
                
                let context = self.appDelegate.persistentContainer.viewContext
                
                let newTask = Task(context: context)
                
                //TODO: tách thành hàm save()
                
                newTask.id = Int16(idTextField.text!) ?? 0
                newTask.name = nameTextField.text!
                newTask.status = 0
                newTask.taskDetail = taskDetailTextField.text!
                newTask.ofUser = nil
                
                self.appDelegate.saveContext()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        addTaskAlert.addAction(addUserAction)
        addTaskAlert.addAction(cancelAction)
    }
    
    func loadAllTask() {
        
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    @IBAction func addTaskDidTapped(_ sender: UIBarButtonItem) {
        self.present(addTaskAlert, animated: true, completion: nil)
    }
    
}

//
//MARK: - UITableViewDataSource
//
extension ListTaskVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = fetchResultsController.sections else { return 0 }
        
        return sections[section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell {
            
            guard let task = fetchResultsController.object(at: indexPath) as? Task else {
                return UITableViewCell()
            }
            
            cell.taskIDLabel.text = "\(task.id)"
            cell.taskNameLabel.text = "\(task.name ?? "")"
            cell.userLabel.text = "\(task.ofUser?.firstName ?? "")"
            
            if task.status == 0 {
                cell.doneButton.setTitle("Done", for: .normal)
                cell.accessoryType = .none
            } else {
                cell.doneButton.setTitle("Not done", for: .normal)
                cell.accessoryType = .checkmark
            }
            
            cell.delegate = self
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

//
//MARK: - UITableViewDelegate
//
extension ListTaskVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//
//MARK: - UserCellDelegate
//
extension ListTaskVC: TaskCellDelegate {
    
    func doneTask(at cell: TaskCell) {
        if let index = contentTableView.indexPath(for: cell) {
            
            guard let task = fetchResultsController.object(at: index) as? Task else {
                return
            }
            
            //TODO: Tách thành hàm delete()
            
            let manageContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
            let idPredicate = NSPredicate(format: "id = %i", task.id)
            fetchRequest.predicate = idPredicate
            
            do {
                let editTasks = try manageContext.fetch(fetchRequest)
                
                for task in editTasks {
                    
                    if task.status == 0 {
                        task.status = 1
                    } else {
                        task.status = 0
                    }
                    
                    try manageContext.save()
                }
                
            } catch {
                print("load All User Error: \(error.localizedDescription)")
            }
        }
    }
    
    func remove(at cell: TaskCell) {
        
        if let index = contentTableView.indexPath(for: cell) {
            
            guard let task = fetchResultsController.object(at: index) as? Task else {
                return
            }
            
            //TODO: Tách thành hàm delete()
            
            let manageContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
            let idPredicate = NSPredicate(format: "id = %i", task.id)
            fetchRequest.predicate = idPredicate
            
            do {
                let deleteTasks = try manageContext.fetch(fetchRequest)
                
                for task in deleteTasks {
                    manageContext.delete(task)
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
extension ListTaskVC: NSFetchedResultsControllerDelegate {
    
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

