//
//  AppCoordinator.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 01/02/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    var navigationController : UINavigationController?
    
    required init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if let window = UIApplication.shared.delegate?.window {
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
    
}
