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

class PhotoAdditionalInfoViewController: UIViewController {
    
    //MARK: - Instance Variables

    private let disposeBag = DisposeBag()
    
    @IBOutlet weak private var blurView: UIVisualEffectView!
    
    @IBOutlet weak private var tableView: UITableView!
    
    private var viewModel : PhotoAdditionalInfoViewModel?
    
    //MARK: - Setup
    
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
            .bind(to: tableView.rx.items(cellIdentifier: "cell")) { _, element, cell in
                cell.textLabel?.text = element.0
                cell.detailTextLabel?.text = element.1
            }
            .disposed(by: disposeBag)
    }
    
}
