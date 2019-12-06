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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        changeImage()
    }
    
    
    @IBAction func logTapOnImage(_ sender: UILongPressGestureRecognizer) {
        changeImage()
    }
    
    @objc func changeImage() {
        let image1 = UIImage(named: "pig")
        let image2 = UIImage(named: "bird")
        
        if self.imageView.image == image1 {
            self.imageView.image = image2
        } else {
            self.imageView.image = image1
        }
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
    
    
    @IBAction func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        
        let image1 = UIImage(named: "pig")
        let image2 = UIImage(named: "bird")
        
        if sender.direction == .right {
            self.imageView.image = image1
        } else if sender.direction == .left {
             self.imageView.image = image2
        }
    }
    
}

