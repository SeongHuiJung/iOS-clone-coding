//
//  SegueDetailViewController.swift
//  iOS-lecture-study
//
//  Created by 정성희 on 2024/02/05.
//

import UIKit

class SegueDetailViewController: UIViewController {
    var someString = ""
    
    @IBOutlet weak var someLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        someLabel.text=someString
    }
    

}
