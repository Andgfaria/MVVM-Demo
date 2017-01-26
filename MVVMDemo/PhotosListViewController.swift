//
//  ViewController.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 24/01/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class PhotosListViewController: UIViewController, UITableViewDelegate {
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak private var tableView: UITableView!
    
    private let photoCellReuseIdentifier = NSStringFromClass(FullSizePhotoTableViewCell.self)
    
    private let viewModel = PhotosListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FullSizePhotoTableViewCell.self, forCellReuseIdentifier: photoCellReuseIdentifier)
        viewModel.photos.asObservable().bindTo(tableView.rx.items(cellIdentifier: photoCellReuseIdentifier, cellType: FullSizePhotoTableViewCell.self)) { (row, element, cell) in
            if let url = URL(string: element.regularSizeURL) {
                cell.imageView?.kf.setImage(with: url)
                cell.imageView?.contentMode = .scaleAspectFill
            }
        }.addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewWidth = Double(tableView.bounds.width)
        return CGFloat(viewModel.heightForPhoto(atIndex: indexPath.row, withWidth:tableViewWidth))
    }
    
}

