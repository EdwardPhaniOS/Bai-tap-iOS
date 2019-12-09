//
//  ViewController.swift
//  Gesture
//
//  Created by iMac_VTCA on 12/6/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var swipeArea: UIView!
    
    let images = [
        UIImage(named: "pic1"),
        UIImage(named: "pic2"),
        UIImage(named: "pic3"),
        UIImage(named: "pic4"),
    ]
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        rightSwipeGesture.direction = .right
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        leftSwipeGesture.direction = .left
        
        swipeArea.addGestureRecognizer(leftSwipeGesture)
        swipeArea.addGestureRecognizer(rightSwipeGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        changeToNextImage()
    }
    
    
    @IBAction func logTapOnImage(_ sender: UILongPressGestureRecognizer) {
        changeToNextImage()
    }
    
    @objc func changeToNextImage() {
        
        if currentIndex < images.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        
        self.imageView.image = images[currentIndex]
        
    }
    
    func changeToPreviousImage() {
        
        if currentIndex > 0 {
            currentIndex -= 1
        } else {
            currentIndex = images.count - 1
        }
        
        self.imageView.image = images[currentIndex]
    }
    
    var lastRotation: CGFloat = 0
    
    @IBAction func handleRotation(_ sender: UIRotationGestureRecognizer) {
        
        var originRotation = CGFloat()
        
        //Cac trang thai cua Long Gesutre (Pan, Rotate, Pinch,...)
        if sender.state == .began {
            print("began")
            
            //Bat dau quay voi goc toa do tu lan quay gan nhat
            sender.rotation = lastRotation
            originRotation = sender.rotation
            
        } else if sender.state == .changed {
            print("changing")
            
            //Goc quay moi se la goc toa do + goc quay cua gesture
            let newRotation = sender.rotation + originRotation
            sender.view?.transform = CGAffineTransform(rotationAngle: newRotation)
            
        } else if sender.state == .ended {
            print("End")
            
            //Cap nhat goc toa do moi nhat
            lastRotation = sender.rotation
            
            //Khi ta quay, ta quay luon ca goc toa do -> goc quay se chinh xac nhat
        }
        
        
    }
    
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        
        //Bring view in self.view to front
        self.view.bringSubviewToFront(imageView)
        
        //tinh toa do dich chuyen cua pan gesture dua theo he toa do cua self.view
        let translation = sender.translation(in: self.view)
        //cho view cua pan gesture thay doi tuong ung voi toa do dich chuyen
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        
        //Cai dat pan gesture dich chuyen theo tinh toan
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @IBAction func handlePinchGesture(_ sender: UIPinchGestureRecognizer) {
        
        if sender.state == .changed {
            sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            sender.scale = 1.0
        }
    }
    
    
    @objc func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        
        if sender.direction == .right {
            changeToNextImage()
        } else if sender.direction == .left {
            changeToPreviousImage()
        }
    }
    
}

