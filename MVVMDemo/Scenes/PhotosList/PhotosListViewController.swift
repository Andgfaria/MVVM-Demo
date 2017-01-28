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
    
    @IBOutlet weak private var tableView: UITableView!
    
    private let reuseIdentifier = NSStringFromClass(FullSizePhotoTableViewCell.self)
    
    private let viewModel = PhotosListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FullSizePhotoTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        setupBinding()
    }

    private func setupBinding() {
        viewModel.photos
                 .asObservable()
                 .subscribeOn(MainScheduler.instance)
                 .bindTo(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: FullSizePhotoTableViewCell.self))
                 { _, element, cell in
                    cell.imageView?.kf.indicatorType = .activity
                    if let url = self.viewModel.previewPhotoUrlFor(element) {
                        cell.imageView?.kf.setImage(with: url, placeholder: UIImage())
                    }
                 }
                 .addDisposableTo(disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewWidth = Double(tableView.bounds.size.width)
        return CGFloat(viewModel.heightForPhoto(atIndex: indexPath.row, withWidth: tableViewWidth))
    }
}
