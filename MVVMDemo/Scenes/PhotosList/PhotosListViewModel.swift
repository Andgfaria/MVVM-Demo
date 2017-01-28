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

enum PhotosListState {
    case initialLoading,
         initialLoadingFailure,
         normal,
         loadingNextPage
}

struct PhotosListViewModel {
    
    private var currentPage = Variable(0)
    
    var currentState = Variable(PhotosListState.initialLoading)
    
    private let disposeBag = DisposeBag()
    
    var photos = Variable<[UnsplashPhoto]>([])
    
    init() {
        setupPageBinding()
    }
    
    private func setupPageBinding() {
        currentState.asObservable().subscribe(onNext: { currentState in
            if currentState == .initialLoading || currentState == .loadingNextPage {
                self.fetchNextPageOfPhotos()
            }
        }).addDisposableTo(disposeBag)
        photos.asObservable()
              .map { $0.count > 0 ? self.currentPage.value + 1 : self.currentPage.value }
              .bindTo(currentPage)
              .addDisposableTo(disposeBag)
    }
    
    func heightForPhoto(atIndex index : Int, withWidth width: Double) -> Double {
        let photo = photos.value[index]
        return (photo.height * width) / photo.width
    }
    
    func previewPhotoUrlFor(_ photo : UnsplashPhoto) -> URL? {
        return URL(string: photo.regularSizeURL)
    }

    private func fetchNextPageOfPhotos() {
        UnsplashConnection.shared.photos(ofPage: currentPage.value + 1)
        .subscribe(onNext: { fetchedPhotos in
            if fetchedPhotos.count > 0 {
                self.photos.value.append(contentsOf: fetchedPhotos)
                self.currentState.value = .normal
            }
            else {
                self.currentState.value = self.currentState.value == .initialLoading ? .initialLoadingFailure : .normal
            }
        }, onError: { error in
            self.currentState.value = self.currentState.value == .initialLoading ? .initialLoadingFailure : .normal
        })
        .addDisposableTo(disposeBag)
    }
    
}
