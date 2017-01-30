//
//  CustomRoundedButton.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 28/01/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit

@IBDesignable class CustomRoundedButton: UIButton {

    @IBInspectable var radius : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }

    override var isHighlighted: Bool {
        didSet {
            self.alpha = isHighlighted ? 0.75 : 1
        }
    }
    
}
