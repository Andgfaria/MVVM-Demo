//
//  UserInfoViewController.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 03/02/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit
import Kingfisher
import RxCocoa
import RxSwift

class UserInfoViewController: UIViewController {
    
    private let disposeBag = DisposeBag()

    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameTextField: UILabel!
    
    private var viewModel : UserInfoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.layer.cornerRadius = 15.0
        blurView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.bounds.size.width / 2
        userImageView.layer.masksToBounds = true
        setupBindings()
    }

    func configureViewModel(with user : UnsplashUser) {
        if viewModel == nil {
            viewModel = UserInfoViewModel()
        }
        viewModel?.user.value = user
    }
    
    private func setupBindings() {
        viewModel?.user.asObservable()
                       .map { $0?.name ?? "" }
                       .bindTo(userNameTextField.rx.text)
                       .addDisposableTo(disposeBag)
        viewModel?.user.asObservable()
                      .subscribe(onNext: {
                            if let user = $0 {
                                self.loadProfileImage(of: user)
                            }
                            self.userNameTextField.sizeToFit()
                      })
                      .addDisposableTo(disposeBag)
    }
    
    private func loadProfileImage(of user: UnsplashUser) {
        if let url = URL(string: user.profilePictureURL) {
            userImageView.kf.setImage(with: url)
        }
    }
}
