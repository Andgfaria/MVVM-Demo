//
//  PhotosListViewModel.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 24/01/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct PhotosListViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let reuseIdentifier = "photoCell"
    
    var photos = Variable<[UnsplashPhoto]>([])
    
    init() {
        fetchPhotos()
    }
    
    func heightForPhoto(atIndex index : Int, withWidth width: Double) -> Double {
        let photo = photos.value[index]
        return (photo.height * width) / photo.height
    }

    func fetchPhotos() {
        UnsplashConnection.shared.photos().subscribe(onNext: { fetchedPhotos in
            self.photos.value.append(contentsOf: fetchedPhotos)
        }, onError: { error in
            
        }).addDisposableTo(disposeBag)
    }
    
}
