//
//  ClosureDetailViewController.swift
//  iOS-lecture-study
//
//  Created by 정성희 on 2024/02/09.
//

import UIKit

class ClosureDetailViewController: UIViewController {
    //closure 는 매개변수 이름이 따로 없어서 그냥 타입만 써주게 됨
    var myClosure: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func closurePassData(_ sender: Any) {
        //호출은 여기서 하는 것임
        myClosure?("closure pass data")
        self.dismiss(animated: true )
    }
    
}
