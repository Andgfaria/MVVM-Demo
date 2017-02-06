//
//  PhotoDetailPageViewController.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 03/02/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit

class PhotoDetailPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    let userInfoViewController = UIStoryboard(name: "PhotoDetail", bundle: nil).instantiateViewController(withIdentifier: NSStringFromClass(UserInfoViewController.self)) as? UserInfoViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.setViewControllers([userInfoViewController!], direction: .forward, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }

}
