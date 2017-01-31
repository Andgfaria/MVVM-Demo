//
//  EmptyView.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 30/01/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit

@IBDesignable class EmptyView: UIView {

    @IBOutlet private var view: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button: CustomRoundedButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "EmptyView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.frame = self.bounds
    }
    
}
