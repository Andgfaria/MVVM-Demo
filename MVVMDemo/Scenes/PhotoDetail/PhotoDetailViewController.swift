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
    
    @IBOutlet weak private var scrollView: UIScrollView!
    
    @IBOutlet weak private var imageView: UIImageView!
    
    @IBOutlet weak private var aditionalInfoContainerView: UIView!
    
    @IBOutlet weak private var additionalInfoContainerViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak private var infoButtonVisualEffectView: UIVisualEffectView!
    
    @IBOutlet weak private var infoButton: UIButton!
    
    var viewModel : PhotoDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupInfoButton()
        setupContainerViewPositioning()
        setupImageBinding()
        setupDetailInfoPages()
        setupInfoButtonBinding()
        setupDismissInfoTapGestureRecognizer()
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
    
    private func setupInfoButton() {
        infoButtonVisualEffectView.layer.cornerRadius = infoButtonVisualEffectView.bounds.width / 2
        infoButtonVisualEffectView.layer.masksToBounds = true
    }
    
    private func setupContainerViewPositioning() {
        additionalInfoContainerViewTopConstraint.constant = self.view.bounds.size.height
        self.view.layoutIfNeeded()
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
    
    private func setupDetailInfoPages() {
        if let photo = viewModel?.photo {
            viewModel?.detailInfoCoordinator = PhotoDetailInfoCoordinator(containerView: aditionalInfoContainerView, photo: photo.value
            )
        }
    }
    
    private func setupInfoButtonBinding() {
        viewModel?.currentState.asObservable()
                                .subscribe(onNext: {
                                    self.infoButtonVisualEffectView.effect = UIBlurEffect(style: $0 == .normal ? .dark : .extraLight)
                                })
                                .addDisposableTo(disposeBag)
        viewModel?.currentState.asObservable()
                               .skip(1)
                               .subscribe(onNext: {
                                    self.animateContainerViewTransition(with: $0)
                               })
                               .addDisposableTo(disposeBag)
        if let viewModel = viewModel {
            infoButton.rx.tap.asObservable()
                             .map{ viewModel.currentState.value == .normal ? PhotoDetailState.showingMoreInfo : PhotoDetailState.normal }
                             .bindTo(viewModel.currentState)
                             .addDisposableTo(disposeBag)
        }
    }
    
    private func animateContainerViewTransition(with state : PhotoDetailState) {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.additionalInfoContainerViewTopConstraint.constant = state == .normal ?
                self.view.bounds.size.height : 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setupDismissInfoTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDismissInfoTap))
        aditionalInfoContainerView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func handleDismissInfoTap() {
        viewModel?.currentState.value = .normal
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
