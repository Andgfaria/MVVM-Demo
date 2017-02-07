//
//  PhotoDetailViewModel.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 01/02/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import Foundation
import RxSwift

enum PhotoDetailState {
    case normal, showingMoreInfo
}

class PhotoDetailViewModel {

    var currentState = Variable(PhotoDetailState.normal)
    
    var photo : Variable<UnsplashPhoto>!
    
    var detailInfoCoordinator : PhotoDetailInfoCoordinator?
    
    required init(photo : UnsplashPhoto) {
        self.photo = Variable(photo)
    }
    
}
