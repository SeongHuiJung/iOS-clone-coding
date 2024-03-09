//
//  ViewController.swift
//  Navigation-Master
//
//  Created by 정성희 on 2024/03/07.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviTitle()
        setNaviBackBtn()
    }

    @objc func clickBtn() {
        print("click")
    }
    
    
    func setNaviBackBtn() {
        // 뒤로 가기 버튼 아이콘 그림으로 설정
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(systemItem: .bookmarks)
        
        // 뒤로가기 버튼 텍스트 설정
        self.navigationItem.backButtonTitle = ""
        
        // 이미지 원본 그대로 사용 설정하면서 이미지 저장
        // 현재 ArrowR 이미지의 원래 이름은 ArrowR@3x 였으나 실제 사용할 때는 @뒷부분을 제외한 앞부분을 사용한다
        // 3x의 의미는 기존 픽셀크기의 3배라는 의미이다
        // 3배로 설정하는 이유는 보통 우리가 사용하는 디바이스(핸드폰) 은 해상도의 3배이기 때문에 원래 설정하려고 했던 크기(40px)이 아닌 (120px)으로 설정해주는 것임
        let backImage = UIImage(named: "ArrowR")?.withRenderingMode(.alwaysOriginal)
        
        // 왼쪽 화살표 부분은 이렇게 설정해주어야 함
        // backIndicatorImage 와 backIndicatorTransitionMaskImage 두 속성 모두에 이미지를 적용시켜 주어야 작동함
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        
        // 색지정
        self.navigationController?.navigationBar.tintColor = .red
    }

    func setNaviTitle() {
        // 버튼 설정
        var btn = UIButton()
        btn.setTitle("button", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // 버튼에 동작 추가
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        
        // 버튼 네비게이션에 보이도록 추가
        navigationItem.titleView = btn
    }
}

