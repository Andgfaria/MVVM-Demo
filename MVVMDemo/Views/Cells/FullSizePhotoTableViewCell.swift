//
//  FullSizeImageTableViewCell.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 24/01/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit

class FullSizePhotoTableViewCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = self.contentView.frame
        self.imageView?.contentMode = .scaleAspectFit
        self.backgroundColor = .black
    }

}
