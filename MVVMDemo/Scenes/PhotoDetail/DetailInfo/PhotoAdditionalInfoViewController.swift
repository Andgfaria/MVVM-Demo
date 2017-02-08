//
//  PhotoAdditionalInfoViewController.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 08/02/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import UIKit

class PhotoAdditionalInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var blurViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var blurViewCenterConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.layer.cornerRadius = 15.0
        blurView.layer.masksToBounds = true
        tableView.rowHeight = 56
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        tableViewHeightConstraint.constant = tableView.contentSize.height
        if tableViewHeightConstraint.constant > self.view.bounds.size.height {
            blurViewCenterConstraint.isActive = false
            blurViewTopConstraint.isActive = true
        }
        else {
            blurViewTopConstraint.isActive = false
            blurViewCenterConstraint.isActive = true
        }
        self.view.layoutIfNeeded()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
