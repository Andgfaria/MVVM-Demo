//
//  EmptyView.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 30/01/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit
import RxSwift

enum EmptyViewState {
    case loading,
         noContent
}

@IBDesignable class EmptyView: UIView {
    
    private let disposeBag = DisposeBag()

    var currentState = Variable(EmptyViewState.loading)
    
    @IBOutlet private var view: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button: CustomRoundedButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "EmptyView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        setupStateBinding()
    }
    
    private func setupStateBinding() {
        currentState.asObservable()
                    .subscribe(onNext: {
                        self.activityIndicator.isHidden = false // $0 != .loading
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
