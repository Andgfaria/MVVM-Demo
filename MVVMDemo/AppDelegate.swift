//
//  AppDelegate.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 24/01/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var appCoordinator : AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let mainNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? UINavigationController {
            appCoordinator = AppCoordinator(navigationController: mainNavigationController)
            appCoordinator?.start()
        }
        
        return true
    }


}

