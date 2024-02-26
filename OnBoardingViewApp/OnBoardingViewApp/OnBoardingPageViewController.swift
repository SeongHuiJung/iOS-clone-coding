//
//  OnBoardingPageViewController.swift
//  OnBoardingViewApp
//
//  Created by 정성희 on 2024/02/21.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {
    //page 들을 담을 uiviewcontroller 배열 선언
    var pages = [UIViewController]()

    //속성 값 바꿔서 특정 페이지에서만 버튼 보이게 할때 이미 정해뒀던 속성 값을 수정할 수 있게 변수로 저장해둠
    //어떤 ui 변수인지, 뭐랑 연결해놨는지, constant 저장가능
    var bottomButtonMargin : NSLayoutConstraint?
    let startIdx = 0
    var pageControl = UIPageControl()
    var currentIdx = 0 {
        didSet { //currentIdx 값이 바뀔 때마다 didset 실행
            pageControl.currentPage = currentIdx
        }
    }
    
    func makePageVC () {
        let itemVC1 = OnBoardingItemViewController(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC1.mainText = "Focus on your ideal buyer"
        itemVC1.topImage = UIImage(named: "onboarding1")
        itemVC1.subText = "When you write a product description with a huge crowd of buyers in mind, your description became wishy-washy and you end up addressing no one at all"
        
        let itemVC2 = OnBoardingItemViewController(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC2.mainText = "Entice with benefits"
        itemVC2.topImage = UIImage(named: "onboarding2")
        itemVC2.subText = "When we well our own products, we get excited about individual product features and specifications. We ive and breathe our company, our website, and our products."
        
        let itemVC3 = OnBoardingItemViewController(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC3.mainText = "Avoid yeah, yeah phrases"
        itemVC3.topImage = UIImage(named: "onboarding3")
        itemVC3.subText = "When we're stuck for words and don't know what else to add to our product description, we often add something bland like \"excellent product quality\"."
        
        pages.append(itemVC1)
        pages.append(itemVC2)
        pages.append(itemVC3)
        
        //필수 설정
        //기본으로 첫번째 화면으로 나와야 하는 것을 설정
        setViewControllers([itemVC1], direction: .forward, animated: true)
        
        self.dataSource = self
        self.delegate = self
    }
    
    func makeBottomBtn () {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        
        // 눌렀을 때 실행할 것
        button.addTarget(self, action: #selector(dissmissPageVC), for: .touchUpInside)
        
        //self 에 있는 view 컨트롤러에 있는 view 에 view 를 추가하겠다
        self.view.addSubview(button)
        
        //auto layer 를 하려면 아래 속성 값이 false 이어야함. 왜?
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //code 를 통한 auto layer 설정
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bottomButtonMargin = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomButtonMargin?.isActive = true
        
        hideButton()
    }
    
    func makePageControl () {
        // 화면에 올리기
        self.view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = startIdx
        
        // auto layer setting
        pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        //아래 점 클릭 비활성화 하려면 false 로 할것.
        pageControl.isUserInteractionEnabled = true
        
        //점 클릭 시 해당 페이지로 가게 하는 이벤트 생성
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
    }
    
    @objc func pageControlTapped (sender: UIPageControl){
        //sender.currentPage : 지금 내가 누른 페이지
        //self.currentIdx : 현재 페이지
        if (sender.currentPage > self.currentIdx) {
            self.setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true)
        }
        else {
            self.setViewControllers([pages[sender.currentPage]], direction: .reverse, animated: true)
        }
        
        currentIdx = sender.currentPage
        buttonPresentation()
    }
    
    
    //셀렉터는 런타임에서 발생, 실행할 수 있는 규격이라 @objc 를 붙여줘야함
    @objc func dissmissPageVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makePageVC()
        makeBottomBtn()
        makePageControl()
    }
}

extension OnBoardingPageViewController: UIPageViewControllerDataSource {
    //필수. 이전 페이지 무엇?
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("idx 알아내는 before extension")
        //현재 보여지고 있는 페이지 idx를 알아냄
        //아래 주석의 currentidx 는 optional 인 상태라 값을 가져오지 못한다면   뷰컨트롤이 뭔지 알 수 없는 상황이라 다음, 이전 페이지에 대한 개념을 확인할 수 없음
        //결론은 optional 상태를 풀어줘야 한다는 의미.
        //guard let 으로 한다면 풀어줄 수있다
        //let currentIdx = pages.firstIndex(of: viewController)
        guard let currentIdx = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        self.currentIdx = currentIdx
        
        //마지막 페이지일 경우 마지막 페이지로
        if (currentIdx == 0 ) {
            return pages.last
        }
        return pages[currentIdx-1]
    }
    
    //필수. 다음 페이지 무엇?
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("idx 알아내는 after extension")
        guard let currentIdx = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        self.currentIdx = currentIdx
        
        //마지막 페이지일 경우 첫번째 페이지로
        if currentIdx == pages.count - 1 {
            return pages.first
        }
        return pages[currentIdx + 1]
    }
}


//현재 페이지가 어딘지 알려줄 수 있는 기능 제공해서 사용함
extension OnBoardingPageViewController: UIPageViewControllerDelegate {
    //여기선 필수로 구현해야하는게 없어서 아무것도 없어도 에러는 안남
    
    //화면넘긴 직후에 실행됨
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        //view controller 는 pageviewcontroller 안에 들어 있어서
        //인자로 viewcontroller 가 주어지지 않더라도 pageViewController 를 통해 현재 보여지고 있는 VC 를 구할 수 있음
        guard let currentVC = pageViewController.viewControllers?.first else {
            return
        }
        
        guard let currentIdx = pages.firstIndex(of: currentVC) else {
            return
        }
        
        self.currentIdx = currentIdx
        
        //마지막 페이지인 경우에만 버튼을 띄워줌
        buttonPresentation()
    }
    func showButton() {
        bottomButtonMargin?.constant = 0
    }
    
    func hideButton() {
        bottomButtonMargin?.constant = 100
    }
    
    func buttonPresentation () {
        if currentIdx == pages.count - 1 {
            self.showButton()
        }else{
            self.hideButton()
        }
        
        //부드럽게 버튼 보이기
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
