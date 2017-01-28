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
    
    private var currentPage = Variable(0)
    
    private let disposeBag = DisposeBag()
    
    var isInitialLoading = Variable(true)
    
    var isLoadingNextPage = Variable(true)
    
    var photos = Variable<[UnsplashPhoto]>([])
    
    init() {
        setupPageBinding()
    }
    
    private func setupPageBinding() {
        isLoadingNextPage.asObservable().subscribe(onNext: { loading in
            if loading {
                self.fetchNextPageOfPhotos()
            }
        }).addDisposableTo(disposeBag)
        photos.asObservable().map { $0.count > 0 ? self.currentPage.value + 1 : self.currentPage.value }.bindTo(currentPage).addDisposableTo(disposeBag)
    }
    
    func heightForPhoto(atIndex index : Int, withWidth width: Double) -> Double {
        let photo = photos.value[index]
        return (photo.height * width) / photo.width
    }
    
    func previewPhotoUrlFor(_ photo : UnsplashPhoto) -> URL? {
        return URL(string: photo.regularSizeURL)
    }

    private func fetchNextPageOfPhotos() {
        UnsplashConnection.shared.photos(ofPage: currentPage.value + 1).subscribe(onNext: { fetchedPhotos in
            self.finishedLoading()
            if fetchedPhotos.count > 0 {
                self.photos.value.append(contentsOf: fetchedPhotos)
            }
        }, onError: { error in
            self.finishedLoading()
        }).addDisposableTo(disposeBag)
    }
    
    private func finishedLoading() {
        self.isInitialLoading.value = false
        self.isLoadingNextPage.value = false
    }
    
}
