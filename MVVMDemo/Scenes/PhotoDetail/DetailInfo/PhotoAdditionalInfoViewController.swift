//
//  PhotoAdditionalInfoViewController.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 08/02/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PhotoAdditionalInfoViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    @IBOutlet weak private var blurView: UIVisualEffectView!
    
    @IBOutlet weak private var tableView: UITableView!
    
    private var viewModel : PhotoAdditionalInfoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.layer.cornerRadius = 15.0
        blurView.layer.masksToBounds = true
        setupBinding()
        tableView.reloadData()
    }
    
    func configureViewModel(with photo : UnsplashPhoto) {
        viewModel = PhotoAdditionalInfoViewModel(photo: photo)
    }
    
    private func setupBinding() {
        viewModel?.infoTexts.asObservable()
            .bindTo(tableView.rx.items(cellIdentifier: "cell")) { _, element, cell in
                cell.textLabel?.text = element.0
                cell.detailTextLabel?.text = element.1
            }
            .addDisposableTo(disposeBag)
    }
    
}
