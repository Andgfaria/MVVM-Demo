//
//  PhotoAdditionalInfoViewModel.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 09/02/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import Foundation
import RxSwift

class PhotoAdditionalInfoViewModel {
    
    static private let dateFormatter = DateFormatter()
    
    var infoTexts = Variable<[(String,String)]>([])

    required init(photo : UnsplashPhoto) {
        setupInfoTexts(with: photo)
    }
    
    private func setupInfoTexts(with photo : UnsplashPhoto) {
        var texts = [(String,String)]()
        if let city = photo.city {
            texts.append(("City",city))
        }
        if let date = photo.created_at {
            PhotoAdditionalInfoViewModel.dateFormatter.dateStyle = .short
            texts.append(("Date",PhotoAdditionalInfoViewModel.dateFormatter.string(from: date)))
        }
        texts.append(("Size","\(photo.width) x \(photo.height)"))
        infoTexts.value = texts
    }
    
}

