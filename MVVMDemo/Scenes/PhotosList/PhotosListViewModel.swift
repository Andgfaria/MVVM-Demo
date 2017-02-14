/*
 The MIT License (MIT)
 
 Copyright (c) 2017 André Gimenez Faria
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

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
    
    //MARK: - Instance Variables
    
    private var currentPage = Variable(0)
    
    var currentState = Variable(PhotosListState.initialLoading)
    
    private let disposeBag = DisposeBag()
    
    var photos = Variable<[UnsplashPhoto]>([])
    
    //MARK: - Custom Init
    
    init() {
        setupPageBinding()
    }
    
    //MARK: - Bindings
    
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
    
    //MARK: - Datasource
    
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
