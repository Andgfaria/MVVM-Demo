//
//  AppCoordinator.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 01/02/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit

class AppCoordinator : PhotosListRoutingDelegate {
    
    var navigationController : UINavigationController?
    
    required init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if let window = UIApplication.shared.delegate?.window {
            if let photosListController = navigationController?.viewControllers[0] as? PhotosListViewController {
                photosListController.routingDelegate = self
            }
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
    
    func handlePhotoSelection(_ photo: UnsplashPhoto) {
        if let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: NSStringFromClass(PhotoDetailViewController.self)) as? PhotoDetailViewController {
            detailController.configure(with: photo)
            navigationController?.pushViewController(detailController, animated: true)
        }
    }
}
