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
import PureLayout

class PhotoDetailInfoCoordinator {
    
    weak var containerView : UIView?
    
    var photo : UnsplashPhoto?
    
    private let photoDetailStoryboard = UIStoryboard(name: "PhotoDetail", bundle: nil)
    
    private var detailPageViewController : PhotoDetailPageViewController?
    
    required init(containerView: UIView, photo: UnsplashPhoto) {
        self.containerView = containerView
        self.photo = photo
        setupDetailPageViewController(in: containerView,with: photo)
    }
    
    private func setupDetailPageViewController(in view : UIView, with photo : UnsplashPhoto) {
        if let pageViewController = photoDetailStoryboard.instantiateViewController(withIdentifier: NSStringFromClass(PhotoDetailPageViewController.self)) as? PhotoDetailPageViewController {
            detailPageViewController = pageViewController
            if let user = photo.user {
                detailPageViewController?.userInfoViewController?.configureViewModel(with: user)
            }
            detailPageViewController?.photoInfoViewController?.configureViewModel(with: photo)
            if let view = detailPageViewController?.view {
                containerView?.addSubview(view)
            }
            detailPageViewController?.view.autoPinEdgesToSuperviewEdges()
        }
    }
    
    
}
