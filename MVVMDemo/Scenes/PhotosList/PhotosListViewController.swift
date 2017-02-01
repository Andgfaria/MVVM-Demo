//
//  PhotosListViewController.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 28/01/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class PhotosListViewController: UIViewController, UITableViewDelegate {
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak private var emptyView: EmptyView!
    
    @IBOutlet weak var loadMoreView: LoadMoreView!
    
    @IBOutlet weak private var tableView: UITableView!
    
    private let reuseIdentifier = NSStringFromClass(FullSizePhotoTableViewCell.self)
    
    private let viewModel = PhotosListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FullSizePhotoTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        setupBinding()
    }
    
    private func setupBinding() {
        setupTableViewBinding()
        setupEmptyViewBinding()
        setupFooterBinding()
    }
    
    private func setupTableViewBinding() {
        viewModel.photos
            .asObservable()
            .bindTo(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: FullSizePhotoTableViewCell.self))
            { _, photo, cell in
                cell.imageView?.backgroundColor = UIColor(hex: photo.colorString)
                if let url = self.viewModel.previewPhotoUrlFor(photo) {
                    cell.imageView?.kf.setImage(with: url, placeholder: UIImage())
                }
            }
            .addDisposableTo(disposeBag)
        viewModel.currentState
                 .asObservable()
                 .map { $0 == .initialLoading || $0 == .initialLoadingFailure }
                 .bindTo(tableView.rx.isHidden)
                 .addDisposableTo(disposeBag)
    }
    
    private func setupEmptyViewBinding() {
        viewModel.currentState.asObservable()
                              .map { $0 == .initialLoading ? EmptyViewState.loading : EmptyViewState.noContent }
                              .bindTo(emptyView.currentState)
                              .addDisposableTo(disposeBag)
        viewModel.currentState.asObservable()
                              .map { !($0 == .initialLoading || $0 == .initialLoadingFailure) }
                              .bindTo(emptyView.rx.isHidden)
                              .addDisposableTo(disposeBag)
        emptyView.button.rx.tap
                              .asObservable()
                              .map { PhotosListState.initialLoading }
                              .bindTo(viewModel.currentState)
                              .addDisposableTo(disposeBag)
    }
    
    private func setupFooterBinding() {
        viewModel.currentState.asObservable()
                              .map{ $0 == .loadingNextPage ? LoadMoreViewState.loading : LoadMoreViewState.normal }
                              .bindTo(loadMoreView.currentState)
                              .addDisposableTo(disposeBag)
        loadMoreView.button.rx.tap.asObservable()
                              .map { PhotosListState.loadingNextPage }
                              .bindTo(viewModel.currentState)
                              .addDisposableTo(disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewWidth = Double(tableView.bounds.size.width)
        return CGFloat(viewModel.heightForPhoto(atIndex: indexPath.row, withWidth: tableViewWidth))
    }
    
}
