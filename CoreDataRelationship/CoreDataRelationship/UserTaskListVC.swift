//
//  UserTaskListVC.swift
//  CoreDataRelationship
//
//  Created by Tan Vinh Phan on 2/28/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import UIKit

class UserTaskListVC: UIViewController {

    @IBOutlet weak var taskTableView: UITableView!
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskTableView.dataSource = self
        taskTableView.delegate = self
    }
    

    @IBAction func addButtonDidTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showAddTaskScreen", sender: currentUser)
    }
    

}

//
//MARK: - UITableViewDataSource
//
extension UserTaskListVC: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUser?.task?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTaskCell", for: indexPath) as? UserTaskCell {
            
            guard let allTask = currentUser?.task?.allObjects as? [Task] else {
                return UITableViewCell()
            }
            
            let task = allTask[indexPath.row]
            
            cell.taskIDLabel.text = "\(task.id)"
            cell.taskNameLabel.text = "\(task.name ?? "")"
            
            return cell
        }
        
        return UITableViewCell()
    }
}

//
//MARK: - UITableViewDelegate
//
extension UserTaskListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
