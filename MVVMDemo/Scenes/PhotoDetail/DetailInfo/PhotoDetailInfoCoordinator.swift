//
//  PhotoDetailInfoCoordinator.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 06/02/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit
import PureLayout

class PhotoDetailInfoCoordinator {
    
    weak var containerView : UIView?
    
    var photo : UnsplashPhoto?
    
    private let photoDetailStoryboard = UIStoryboard(name: "PhotoDetail", bundle: nil)
    
    required init(containerView: UIView, photo: UnsplashPhoto) {
        self.containerView = containerView
        self.photo = photo
        setupDetailPageViewController(in: containerView,with: photo)
    }
    
    private func setupDetailPageViewController(in view : UIView, with photo : UnsplashPhoto) {
        if let detailPageViewController = photoDetailStoryboard.instantiateViewController(withIdentifier: NSStringFromClass(PhotoDetailPageViewController.self)) as? PhotoDetailPageViewController {
            if let user = photo.user {
                detailPageViewController.userInfoViewController?.configureViewModel(with: user)
            }
            containerView?.addSubview(detailPageViewController.view)
            detailPageViewController.view.autoPinEdgesToSuperviewEdges()
        }
       
    }
    
    
}
