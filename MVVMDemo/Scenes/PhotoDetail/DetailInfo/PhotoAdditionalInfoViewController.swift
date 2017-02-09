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
    
//    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.layer.cornerRadius = 15.0
        blurView.layer.masksToBounds = true
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Local"
            cell.detailTextLabel?.text = "Paris, França"
        case 1:
            cell.textLabel?.text = "Tamanho"
            cell.detailTextLabel?.text = "5120 x 2880"
        case 2:
            cell.textLabel?.text = "Data"
            cell.detailTextLabel?.text = "13/05/1994"
        default:
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        tableView.reloadData()
//        tableViewHeightConstraint.constant = tableView.contentSize.height
//        if tableViewHeightConstraint.constant > self.view.bounds.size.height {
//            blurViewCenterConstraint.isActive = false
//            blurViewTopConstraint.isActive = true
//        }
//        else {
//            blurViewTopConstraint.isActive = false
//            blurViewCenterConstraint.isActive = true
//        }
//        self.view.layoutIfNeeded()
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
