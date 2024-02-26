//
//  InstanceDetailViewController.swift
//  iOS-lecture-study
//
//  Created by 정성희 on 2024/02/05.
//

import UIKit

class InstanceDetailViewController: UIViewController {
    var mainVC: ViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func sendDataMainVC(_ sender: Any) {
        mainVC?.dataLabel.text="instance 페이지에서 메인으로 보낸 데이터"
        self.dismiss(animated: true) //화면 닫기
    }
    

}
