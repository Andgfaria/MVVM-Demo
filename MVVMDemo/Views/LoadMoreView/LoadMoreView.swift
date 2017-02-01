//
//  LoadMoreView.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 31/01/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit
import RxSwift

enum LoadMoreViewState {
    case normal,
         loading
}

class LoadMoreView: UIView {
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet private var view: UIView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var button: CustomRoundedButton!
    
    var currentState = Variable(LoadMoreViewState.normal)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "LoadMoreView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        setupBinding()
    }
    
    private func setupBinding() {
        currentState.asObservable()
                    .subscribe(onNext: {
                        self.activityIndicator.isHidden = $0 == .normal
                        self.button.isHidden = !self.activityIndicator.isHidden
                    })
                    .addDisposableTo(disposeBag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.frame = self.bounds
    }

}
