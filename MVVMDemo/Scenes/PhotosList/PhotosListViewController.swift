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
    
    @IBOutlet weak private var centerActivityIndicator: UIActivityIndicatorView!

    private let disposeBag = DisposeBag()
    
    @IBOutlet weak private var footerActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak private var loadMoreButton: CustomRoundedButton!
    
    @IBOutlet weak private var tableView: UITableView!
    
    private let reuseIdentifier = NSStringFromClass(FullSizePhotoTableViewCell.self)
    
    private let viewModel = PhotosListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FullSizePhotoTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        setupBinding()
    }

    private func setupBinding() {
        setupInitialLoadingBinding()
        setupTableViewBinding()
        setupFooterBinding()
    }
    
    private func setupInitialLoadingBinding() {
        viewModel.currentState.asObservable()
                              .map{ $0 != .initialLoading }
                              .bindTo(centerActivityIndicator.rx.isHidden)
                              .addDisposableTo(disposeBag)
        viewModel.currentState.asObservable()
                              .map { $0 == .initialLoading || $0 == .initialLoadingFailure }
                              .bindTo(tableView.rx.isHidden)
                              .addDisposableTo(disposeBag)
    }
    
    private func setupTableViewBinding() {
        viewModel.photos
            .asObservable()
            .bindTo(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: FullSizePhotoTableViewCell.self))
            { _, element, cell in
                if let url = self.viewModel.previewPhotoUrlFor(element) {
                    cell.imageView?.kf.setImage(with: url, placeholder: UIImage())
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    private func setupFooterBinding() {
        viewModel.currentState.asObservable()
                              .map{ $0 != .loadingNextPage }
                              .bindTo(footerActivityIndicator.rx.isHidden)
                              .addDisposableTo(disposeBag)
        viewModel.currentState.asObservable()
                              .map { $0 != .normal }
                              .bindTo(loadMoreButton.rx.isHidden)
                              .addDisposableTo(disposeBag)
        loadMoreButton.rx.tap.asObservable()
                              .map { PhotosListState.loadingNextPage }
                              .bindTo(viewModel.currentState)
                              .addDisposableTo(disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewWidth = Double(tableView.bounds.size.width)
        return CGFloat(viewModel.heightForPhoto(atIndex: indexPath.row, withWidth: tableViewWidth))
    }
    
}
