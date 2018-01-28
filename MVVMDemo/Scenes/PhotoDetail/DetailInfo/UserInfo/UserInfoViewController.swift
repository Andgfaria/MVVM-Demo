/*
 The MIT License (MIT)
 
 Copyright (c) 2017 André Gimenez Faria
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

import UIKit
import Kingfisher
import RxCocoa
import RxSwift

class UserInfoViewController: UIViewController {
    
    //MARK: - Instance Variables
    
    private let disposeBag = DisposeBag()

    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameTextField: UILabel!
    
    private var viewModel : UserInfoViewModel?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.layer.cornerRadius = 15.0
        blurView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.bounds.size.width / 2
        userImageView.layer.masksToBounds = true
        setupBindings()
    }

    //MARK: - Setup
    
    func configureViewModel(with user : UnsplashUser) {
        if viewModel == nil {
            viewModel = UserInfoViewModel()
        }
        viewModel?.user.value = user
    }
    
    private func setupBindings() {
        viewModel?.user.asObservable()
                       .map { $0?.name ?? "" }
            .bind(to: userNameTextField.rx.text)
            .disposed(by: disposeBag)
        viewModel?.user.asObservable()
                      .subscribe(onNext: {
                            if let user = $0 {
                                self.loadProfileImage(of: user)
                            }
                            self.userNameTextField.sizeToFit()
                      })
            .disposed(by: disposeBag)
    }
    
    private func loadProfileImage(of user: UnsplashUser) {
        if let url = URL(string: user.profilePictureURL) {
            userImageView.kf.setImage(with: url)
        }
    }
}
