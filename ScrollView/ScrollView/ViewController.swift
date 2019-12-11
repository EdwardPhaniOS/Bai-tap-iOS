//
//  ViewController.swift
//  ScrollView
//
//  Created by iMac_VTCA on 12/11/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(UIScreen.main.bounds.size)
        
//        createScrollView()
    }
    
    func createScrollView() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        scrollView.backgroundColor = UIColor.cyan
        
        let redView = UIView(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        redView.backgroundColor = .red
        
        let greenView = UIView(frame: CGRect(x: 150, y: 160, width: 150, height: 200))
        greenView.backgroundColor = .green
        
        let blueView = UIView(frame: CGRect(x: 40, y: 400, width: 200, height: 150))
        blueView.backgroundColor = .blue
        
        let yellowView = UIView(frame: CGRect(x: 100, y: 600, width: 180, height: 150))
        yellowView.backgroundColor = .yellow
        
        //When create scroll programatically, we need to set content size for scroll View
        
        scrollView.contentSize = CGSize(width: 320, height: 750)
//        scrollView.setContentOffset( CGPoint(x: 0, y: 160), animated: true)
        scrollView.contentOffset = CGPoint(x: 0, y: 160)
        scrollView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 100, right: 0)
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(redView)
        scrollView.addSubview(greenView)
        scrollView.addSubview(blueView)
        scrollView.addSubview(yellowView)
        
        scrollView.delegate = self
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.showsHorizontalScrollIndicator = false
        
        //Default scroll to tops = true ==> Tap on status bar will move to top of scroll view
//        scrollView.scrollsToTop = false
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
}
