//
//  ViewController.swift
//  ImagePicker
//
//  Created by iMac_VTCA on 11/15/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    let imagePickerVC = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func chooseImagePressed(_ sender: UIButton) {
        
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        
        //default source type of imagePickerVC, change to .savedPhotos or .camera if you want
//        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.allowsEditing = true
        
        self.present(imagePickerVC, animated: true, completion: nil)
        
    }
    
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Did finish")
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            myImageView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
//    implement didCancel if you want to custom DidCancel event
    //didCancel default implementation:
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        print("Cancel")
//        picker.dismiss(animated: true, completion: nil)
//    }
    
    
}
