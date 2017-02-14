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
import RxSwift

enum EmptyViewState {
    case loading,
         noContent
}

class EmptyView: UIView {
    
    //MARK: - Instance Variables
    
    private let disposeBag = DisposeBag()

    var currentState = Variable(EmptyViewState.loading)
    
    @IBOutlet private var view: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button: CustomRoundedButton!
    
    //MARK: - Setup
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "EmptyView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        setupStateBinding()
    }
    
    private func setupStateBinding() {
        currentState.asObservable()
                    .subscribe(onNext: {
                        self.activityIndicator.isHidden = $0 != .loading
                        self.label.isHidden = $0 != .noContent
                        self.button.isHidden = self.label.isHidden
                    })
                    .addDisposableTo(disposeBag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.frame = self.bounds
    }
    
}
