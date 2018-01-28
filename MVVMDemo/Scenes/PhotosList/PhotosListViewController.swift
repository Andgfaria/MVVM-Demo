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
import Kingfisher

protocol PhotosListRoutingDelegate : class {
    func handlePhotoSelection(_ photo : UnsplashPhoto)
}

class PhotosListViewController: UIViewController, UITableViewDelegate {
    
    //MARK: - Instance Variables
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak private var emptyView: EmptyView!
    
    @IBOutlet weak var loadMoreView: LoadMoreView!
    
    @IBOutlet weak private var tableView: UITableView!
    
    weak var routingDelegate : PhotosListRoutingDelegate?
    
    private let reuseIdentifier = NSStringFromClass(FullSizePhotoTableViewCell.self)
    
    private let viewModel = PhotosListViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FullSizePhotoTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        setupBinding()
    }
    
    //MARK: - Bindings
    
    private func setupBinding() {
        setupTableViewBinding()
        setupEmptyViewBinding()
        setupFooterBinding()
    }
    
    private func setupTableViewBinding() {
        viewModel.photos
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: FullSizePhotoTableViewCell.self))
            { _, photo, cell in
                cell.imageView?.backgroundColor = UIColor(hex: photo.colorString)
                if let url = self.viewModel.previewPhotoUrlFor(photo) {
                    cell.imageView?.kf.setImage(with: url, placeholder: UIImage())
                }
            }
            .disposed(by: disposeBag)
        viewModel.currentState
                 .asObservable()
                 .map { $0 == .initialLoading || $0 == .initialLoadingFailure }
                 .bind(to: tableView.rx.isHidden)
                 .disposed(by: disposeBag)
        tableView.rx.modelSelected(UnsplashPhoto.self)
                    .subscribe(onNext: {
                        self.routingDelegate?.handlePhotoSelection($0)
                    })
                 .disposed(by: disposeBag)
    }
    
    private func setupEmptyViewBinding() {
        viewModel.currentState.asObservable()
                              .map { $0 == .initialLoading ? EmptyViewState.loading : EmptyViewState.noContent }
                              .bind(to: emptyView.currentState)
                              .disposed(by: disposeBag)
        viewModel.currentState.asObservable()
                              .map { !($0 == .initialLoading || $0 == .initialLoadingFailure) }
                              .bind(to: emptyView.rx.isHidden)
                              .disposed(by: disposeBag)
        emptyView.button.rx.tap
                              .asObservable()
                              .map { PhotosListState.initialLoading }
                              .bind(to: viewModel.currentState)
                              .disposed(by: disposeBag)
    }
    
    private func setupFooterBinding() {
        viewModel.currentState.asObservable()
                              .map{ $0 == .loadingNextPage ? LoadMoreViewState.loading : LoadMoreViewState.normal }
            .bind(to: loadMoreView.currentState)
            .disposed(by: disposeBag)
        loadMoreView.button.rx.tap.asObservable()
                              .map { PhotosListState.loadingNextPage }
            .bind(to: viewModel.currentState)
            .disposed(by: disposeBag)
    }
    
    //MARK: - Tableview Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewWidth = Double(tableView.bounds.size.width)
        return CGFloat(viewModel.heightForPhoto(atIndex: indexPath.row, withWidth: tableViewWidth))
    }
    
}
