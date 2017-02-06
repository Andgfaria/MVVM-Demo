//
//  PhotoDetailViewController.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 01/02/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class PhotoDetailViewController: UIViewController, UIScrollViewDelegate {
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var aditionalInfoContainerView: UIView!
    
    var viewModel : PhotoDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupImageBinding()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configure(with photo : UnsplashPhoto) {
        if let viewModel = viewModel {
            viewModel.photo.value = photo
        }
        else {
            viewModel = PhotoDetailViewModel(photo: photo)
        }
    }
    
    private func setupScrollView() {
        self.scrollView?.minimumZoomScale = 1.0
        self.scrollView?.maximumZoomScale = 3.0
    }
    
    private func setupImageBinding() {
        viewModel?.photo.asObservable()
            .subscribe(onNext: { photo in
                if let regularSizeURL = URL(string: photo.regularSizeURL) {
                    self.imageView?.kf.setImage(with: regularSizeURL, placeholder: UIImage(), completionHandler: { _,_,_,_ in
                        if let fullSizeURL = URL(string: photo.fullSizeURL) {
                            self.imageView?.kf.setImage(with: fullSizeURL, placeholder: self.imageView?.image)
                        }
                    })
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return imageView
    }
}
