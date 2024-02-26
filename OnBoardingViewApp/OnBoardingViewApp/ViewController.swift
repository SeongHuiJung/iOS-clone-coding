//
//  ViewController.swift
//  OnBoardingViewApp
//
//  Created by 정성희 on 2024/02/19.
//

import UIKit

class ViewController: UIViewController {
    
    var didShowOnboardingView = false
    
    // 메모리 영역에 올라감
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    // Ui 화면까지 그려진 이후
    // 화면이 보일 때마다 호출됨
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (didShowOnboardingView == false) {
            didShowOnboardingView = true
            //init -> 화면 켜지자 마자 알아서 다음 뷰가 열리게 함 (메인vc 위로 켜지게)
            //근데 어째 viewDidAppear 에서 페이지 보여주기 하면 그냥 init 하나 안하나 똑같은 것 같다.?
            /*
            var itemVC = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
            self.present(itemVC, animated: true)
             */
            
            //xib 파일이 아니라 nibName 등을 써줄 필요 없이 인스턴스화 할 수 있음.
            let pageVC = OnBoardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
            //아래 코드에서 get-only property : get 기능만 사용 가능하기 때문에, 이런 속성은 생성할때만 설정해줄 수 있음
            //pageVC.transitionStyle = .scroll
            
            //아래에서 뜨는 창으로 떴었는데 fullScreen으로 변경
            pageVC.modalPresentationStyle = .fullScreen
            
            self.present(pageVC, animated: true)
        }
        
    }

}
