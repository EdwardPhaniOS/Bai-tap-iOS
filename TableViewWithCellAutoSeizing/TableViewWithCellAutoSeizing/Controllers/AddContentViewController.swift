//
//  AddContentViewController.swift
//  TableViewWithCellAutoSeizing
//
//  Created by iMac_VTCA on 12/9/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

protocol AddContentViewControllerDelegate {
    
    func addNew(content: Content)
}

class AddContentViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var delegate: AddContentViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func doneButtonTap(_ sender: UIBarButtonItem) {
        
        let title = titleTextField.text
        let description = descriptionTextField.text
        
        guard let safeTitle = title, let safeDescription = description else { return }
        
        let newContent = Content(title: safeTitle, description: safeDescription)
        
        delegate?.addNew(content: newContent)
        
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITextFieldDelegate

extension AddContentViewController: UITextFieldDelegate {
    

}
