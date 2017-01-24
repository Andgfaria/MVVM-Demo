//
//  ViewController.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 24/01/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit
import RxSwift

class PhotosListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak private var tableView: UITableView!
    
    private let photoCellReuseIdentifier = NSStringFromClass(FullSizePhotoTableViewCell.self)
    
    private let viewModel = PhotosListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FullSizePhotoTableViewCell.self, forCellReuseIdentifier: photoCellReuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPhotos()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.idealPhotoHeight(forWidth: tableView.bounds.size.width)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: photoCellReuseIdentifier, for: indexPath)
        if let cell = cell as? FullSizePhotoTableViewCell {
            viewModel.setupPhotoCell(cell)
        }
        return cell
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.tableView.reloadData()
    }
    
}

