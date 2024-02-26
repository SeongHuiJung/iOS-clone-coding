//
//  DelegateDetailViewController.swift
//  iOS-lecture-study
//
//  Created by 정성희 on 2024/02/05.
//

import UIKit
//delegate pattern 은 프로토콜을 만들어서 사용. 주로 해당 클래스 이름에 delegate 를 붙여 명명함
protocol DelegateDetailViewControllerDelegate: AnyObject {
    func passString(string: String) //프로토콜에서 정의한 함수는 이곳에서 body를 정의할 수 없음
}
class DelegateDetailViewController: UIViewController {
    //DelegateDetailViewControllerDelegate 타입의 변수
    weak var delegate: DelegateDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func passDataToMainVC(_ sender: Any) {
        //delegate 를 통해 인스턴스 없이도 접근할 수 있는 대리자를 만듬
        //delegate는 passString 함수를 통해 데이터를 실행해서 함수에 데이터를 넘겨주는 것까지는 됨
        delegate?.passString(string: "delegate pass data")
        self.dismiss(animated: true )
    }
   



}
