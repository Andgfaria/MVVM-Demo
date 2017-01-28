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
    
    var isInitialLoading = Variable(true)
    
    var photos = Variable<[UnsplashPhoto]>([])
    
    init() {
        fetchPhotos()
    }
    
    func heightForPhoto(atIndex index : Int, withWidth width: Double) -> Double {
        let photo = photos.value[index]
        return (photo.height * width) / photo.width
    }
    
    func previewPhotoUrlFor(_ photo : UnsplashPhoto) -> URL? {
        return URL(string: photo.regularSizeURL)
    }

    private func fetchPhotos() {
        UnsplashConnection.shared.photos().subscribe(onNext: { fetchedPhotos in
            self.isInitialLoading.value = false
            self.photos.value.append(contentsOf: fetchedPhotos)
        }, onError: { error in
            self.isInitialLoading.value = false
        }).addDisposableTo(disposeBag)
    }
    
}
