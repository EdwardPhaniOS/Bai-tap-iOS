//
//  PageViewController.swift
//  MyPageView
//
//  Created by iMac_VTCA on 11/15/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

protocol PageViewControllerDelegate: class {
    func didUpdateSegment(with index: Int)
    
}

class PageViewController: UIPageViewController {
    
    private var currentIndex = 0
    
    var customDelegate: PageViewControllerDelegate?
    
    //lazy var: create when need at run-time
    //VC create at build-time, if we create this var arrayViewControllers at build-time, we won't get any VC
    // {...}(): this is a called func
    
    private(set) lazy var arrayViewControllers: [UIViewController] = {
        
        let vc1 = getViewController(color: "Green")
        let vc2 = getViewController(color: "Red")
        let vc3 = getViewController(color: "Blue")
        return [vc1, vc2, vc3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        setViewController(with: currentIndex)
        
    }
    
    func setViewController(with index: Int) {
        if index < arrayViewControllers.count && index >= 0 {
            let vc = arrayViewControllers[index]
            
            let direction = currentIndex > index ?
                UIPageViewController.NavigationDirection.reverse : UIPageViewController.NavigationDirection.forward
            
            self.setViewControllers([vc], direction: direction, animated: true, completion: nil)
            
            self.currentIndex = index
        }
    }
    
    private func getViewController(color: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "\(color)VC")
        return vc
    }
}

//MARK: - UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let indexViewController = arrayViewControllers.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = indexViewController - 1
        
        guard previousIndex >= 0 else {
            return arrayViewControllers[2]
        }
        
        return arrayViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let indexViewController = arrayViewControllers.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = indexViewController + 1
        
        guard nextIndex < arrayViewControllers.count else {
            return arrayViewControllers[0]
        }
        
        return arrayViewControllers[nextIndex]
    }
}

//MARK: - UIPageViewControllerDelegate

extension PageViewController: UIPageViewControllerDelegate {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let visibleViewController = pageViewController.viewControllers?.first {
                if let index = arrayViewControllers.firstIndex(of: visibleViewController) {
                    currentIndex = index
                    customDelegate?.didUpdateSegment(with: index)
                }
            }
            
        }
    }
    
    
    
}
