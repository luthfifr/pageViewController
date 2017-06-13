//
//  PageController.swift
//  pageViewController
//
//  Created by Luthfi Fathur Rahman on 6/13/17.
//  Copyright © 2017 Luthfi Fathur Rahman. All rights reserved.
//

//
//  pageVC.swift
//  pagedView
//
//  Created by Luthfi Fathur Rahman on 6/13/17.
//  Copyright © 2017 Luthfi Fathur Rahman. All rights reserved.
//

import UIKit

class PageController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var arrVCs: [UIViewController] =  {
        return [self.VCInstance(name: "halaman1"), self.VCInstance(name: "halaman2"), self.VCInstance(name: "halaman3"), self.VCInstance(name: "halaman4")]
    }()
    
    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        if let firstVC = arrVCs.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let VCIndex = arrVCs.index(of: viewController) else {
            return nil
        }
        
        let prevVCIndex = VCIndex-1
        
        guard prevVCIndex >= 0 else {
            return arrVCs.last
        }
        
        guard arrVCs.count > prevVCIndex else {
            return nil
        }
        
        return arrVCs[prevVCIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let VCIndex = arrVCs.index(of: viewController) else {
            return nil
        }
        
        let nextVCIndex = VCIndex+1
        
        guard nextVCIndex < arrVCs.count else {
            return arrVCs.first
        }
        
        guard arrVCs.count > nextVCIndex else {
            return nil
        }
        
        return arrVCs[nextVCIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return arrVCs.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        guard let firstVC = viewControllers?.first, let firstVCIndex = arrVCs.index(of: firstVC) else {
            return 0
        }
        return firstVCIndex
    }
    
    /*func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation{
        
        let SpineLocation: UIPageViewControllerSpineLocation = .mid
        
        pageViewController.isDoubleSided = true
        
        return SpineLocation
    }*/
}

