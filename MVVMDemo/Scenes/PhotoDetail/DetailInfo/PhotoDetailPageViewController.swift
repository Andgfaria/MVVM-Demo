//
//  PhotoDetailPageViewController.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 03/02/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit

class PhotoDetailPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let userInfoViewController = UIStoryboard(name: "PhotoDetail", bundle: nil).instantiateViewController(withIdentifier: NSStringFromClass(UserInfoViewController.self)) as? UserInfoViewController
    
    let photoInfoViewController = UIStoryboard(name: "PhotoDetail", bundle: nil).instantiateViewController(withIdentifier: "MVVMDemo.PhotoInfoViewController")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.setViewControllers([userInfoViewController!], direction: .forward, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return viewController == photoInfoViewController ? userInfoViewController : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return viewController == userInfoViewController ? photoInfoViewController : nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pageViewController.viewControllers?[0] is UserInfoViewController ? 0 : 1
    }

}
