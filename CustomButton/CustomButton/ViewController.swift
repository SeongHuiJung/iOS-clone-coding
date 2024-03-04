//
//  ViewController.swift
//  CustomButton
//
//  Created by 정성희 on 2024/03/02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeCustomButton()
    }
    
    // 커스텀 버튼을 코드로서 생성하는 함수
    func makeCustomButton() {
        var myButton = RotateButton()
        self.view.addSubview(myButton)
        
        // autolayer 설정을 하기 위한 설정
        myButton.translatesAutoresizingMaskIntoConstraints = false
        
        // x, y 축 기준 설정
        myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        myButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        // 크기 설정
        myButton.widthAnchor.constraint(equalToConstant: 100)
        myButton.heightAnchor.constraint(equalToConstant: 40)
        
        // 배경설정
        myButton.backgroundColor = UIColor.black
        // 버튼 글씨 설정
        myButton.setTitle("my custom button", for: .normal)
        // 버튼 이미지 설정
        myButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
    }

}

