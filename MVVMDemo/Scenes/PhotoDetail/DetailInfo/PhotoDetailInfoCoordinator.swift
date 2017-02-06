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
        setupDetailPageWiewController(in: containerView)
    }
    
    private func setupDetailPageWiewController(in view : UIView) {
        let detailPageViewController = photoDetailStoryboard.instantiateViewController(withIdentifier: NSStringFromClass(PhotoDetailPageViewController.self))
        containerView?.addSubview(detailPageViewController.view)
        detailPageViewController.view.autoPinEdgesToSuperviewEdges()
    }
    
}
