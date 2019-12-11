//
//  ZoomViewController.swift
//  ZoomViewController
//
//  Created by iMac_VTCA on 12/11/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self

        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 4.0
        scrollView.zoomScale = 1.0
    }
    
    //MARK: - UIScrollViewDelegate methods
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
