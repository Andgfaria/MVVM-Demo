//
//  PhotosListViewModel.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 24/01/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit

struct PhotosListViewModel {
    
    private let reuseIdentifier = "photoCell"
    
    func numberOfPhotos() -> Int {
        return 1
    }
    
    func idealPhotoHeight(forWidth width: CGFloat) -> CGFloat {
        let size = CGSize(width: 800, height: 600)
        return (size.height * width) / size.width
    }
    
    func setupPhotoCell(_ photoCell : FullSizePhotoTableViewCell) {
        photoCell.imageView?.backgroundColor = .gray
        photoCell.imageView?.contentMode = .scaleAspectFit
    }
    
}
