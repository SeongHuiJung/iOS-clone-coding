//
//  RotateButton.swift
//  CustomButton
//
//  Created by 정성희 on 2024/03/02.
//

import UIKit

enum RotateType {
    case up
    case down
}

class RotateButton: UIButton {
    // 해당 버튼을 코드로 생성했을때 실행됨
    // init 에 대한 공부 필요
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    // interface builder(storyboard or xib) 에서 생성하고 RotateButton 클래스를 연결한 버튼은 해당 init 을 통해 호출됨
    // 여기에도 configure 함수를 호출해 주어야 함
    // super.init(frame: .zero) 코드 역시 필요 - 에러 해결
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        print("인터페이스 빌더 연결을 통한 클래스 버튼 생성")
    }
    
    // isUP 값이 바뀔 때 didSet 실행
    var isUP = RotateType.down {
        didSet {
            changeDesign()
        }
    }
    
    // configure 함수를 한번 호출해야 버튼 클릭의 기능이 작동함
    // init 할때 자동으로 한번 실행되게 해야함
    func configure() {
        self.addTarget(self, action: #selector(selectButton), for: .touchUpInside)
    }
    
    var selectTypeCallBack : ((RotateType) -> (Void))?
    
    @objc func selectButton() {
        if isUP == .down {
            isUP = .up
        }
        else {
            isUP = .down
        }
        selectTypeCallBack?(isUP)
    }
    
    // 이미지를 회전시키는 함수
    func changeDesign() {
        // 이미지 회전하는 부분에 애니메이션 넣음
        UIView.animate(withDuration: 0.25) {
            if self.isUP == .up {
                // 버튼에는 기본적으로 이미지가 포함되어 있음
                // 해당 이미지를 180도 회전
                self.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
                //배경 투명화
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.3)
            }
            else {
                // 이미지 회전을 원래대로 초기화
                self.imageView?.transform = .identity
                // 배경 원래대로 초기화
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
            }
        }
    }
}
