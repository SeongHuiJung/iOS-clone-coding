//
//  DetailViewController.swift
//  iOS-lecture-study
//
//  Created by 정성희 on 2024/02/05.
//

import UIKit

class DetailViewController: UIViewController {
    
    //인스턴스 되는 순간 바로 생성됨 : 프로퍼티
    var someString=""

    @IBOutlet weak var someLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //이렇게 임시 프로퍼티인 someString을 생성하고 viewDidLoad에서 값을 넣어주는 이유는 인스턴스화를 통해 ~~~를 먼저 하고 화면에 올라가는 특수 프로퍼티들은 ex)label 맨 마지막에 메모리에 올라가기 때문에 viewDidLoad라는 메모리가 올라갈때 데이터를 넣어줘야함. 다만 일반 프로퍼티는 인스턴스화 함수가 호출되는 동시에 생성되고 메모리에 올라가기 때문에 다른 VC에서 바로 접근가능한 것.
        someLabel.text=someString
        
        
    }



}
