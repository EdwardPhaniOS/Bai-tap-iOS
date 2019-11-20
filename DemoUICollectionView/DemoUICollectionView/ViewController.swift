//
//  ViewController.swift
//  DemoUICollectionView
//
//  Created by iMac_VTCA on 11/18/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

let minSpace: CGFloat = 15
let leftPadding: CGFloat = 20
let rightPadding: CGFloat = leftPadding
let numberOfVisibleCell: CGFloat = 5

class ViewController: UIViewController {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var itemImages = [UIImage]()
    var isChanging = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
        //Dummy data
        if let newImage = UIImage(named: "dao") {
            itemImages.append(newImage)
            itemImages.append(newImage)
            itemImages.append(newImage)
            itemImages.append(newImage)
            itemImages.append(newImage)
            itemImages.append(newImage)
            itemImages.append(newImage)
            itemImages.append(newImage)
            
        }
    }
    
    //MARK: - Add actions
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        let pickerView = UIImagePickerController()
        pickerView.allowsEditing = true
        pickerView.delegate = self
        pickerView.sourceType = .photoLibrary
        
        self.present(pickerView, animated: true, completion: nil)
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        
        if isChanging {
            sender.setTitle("Edit", for: .normal)
            isChanging = false
            
        } else {
            sender.setTitle("Done", for: .normal)
            isChanging = true
        }
        
        myCollectionView.reloadData()
        
        
    }
    
}

//MARK: - UICollectionView Datasource methods

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
            as? CollectionViewCell else { return UICollectionViewCell() }
        
        cell.myImageView.image = itemImages[indexPath.item]
        cell.delegate = self
        cell.indexPath = indexPath
        cell.minusButton.isHidden = !isChanging
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout methods


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewWidth = myCollectionView.frame.width
        
        let width = (collectionViewWidth - (leftPadding + rightPadding) - ((numberOfVisibleCell - 1) * minSpace)) / numberOfVisibleCell
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minSpace
    }
    
}


//MARK: - UICollectionView Delegate methods

extension ViewController: UICollectionViewDelegate {
    
}


//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            itemImages.append(image)
            
            myCollectionView.performBatchUpdates({
                //
                //                let indexSet = IndexSet(integer: 0)
                //                myCollectionView.reloadSections(indexSet)
                
                let indexPath = IndexPath(item: itemImages.count - 1, section: 0)
                myCollectionView.insertItems(at: [indexPath])
                
            }, completion: nil)
            
            //            myCollectionView.reloadData()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
}


//MARK: - CollectionViewCellDelegate

extension ViewController: CollectionViewCellDelegate {
    
    func minusButtonPressed(indexPath: IndexPath) {
        
        let item = indexPath.item
        itemImages.remove(at: item)
        
        UIView.animate(withDuration: 0.2) {
            self.myCollectionView.performBatchUpdates({
                
                let indexSet = IndexSet(integer: 0)
                self.myCollectionView.reloadSections(indexSet)
                
            }, completion: nil)
        }
        //        myCollectionView.reloadData()
        
    }
    
}
