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
    
    var currentPage = Variable(1)
    
    private let disposeBag = DisposeBag()
    
    var isInitialLoading = Variable(true)
    
    var isLoadingNextPage = Variable(false)
    
    var photos = Variable<[UnsplashPhoto]>([])
    
    init() {
        fetchPhotos()
        setupPageBinding()
    }
    
    private func setupPageBinding() {
        currentPage.asObservable().subscribe(onNext: { _ in
            self.isLoadingNextPage.value = true
        }).addDisposableTo(disposeBag)
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
            self.isLoadingNextPage.value = false
            self.photos.value.append(contentsOf: fetchedPhotos)
        }, onError: { error in
            self.isInitialLoading.value = false
            self.isLoadingNextPage.value = false
        }).addDisposableTo(disposeBag)
    }
    
}
