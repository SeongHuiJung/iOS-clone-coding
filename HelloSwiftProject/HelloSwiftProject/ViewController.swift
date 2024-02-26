//
//  ViewController.swift
//  HelloSwiftProject
//
//  Created by 정성희 on 2024/01/15.
//

import UIKit

class ViewController: UIViewController {

    //ctrl 눌러서 ui 랑 연결하는 과정을 어노테이션이라고 부름
    //이렇게 생성된 변수는 아울렛 변수라고 부름
    //outlet 은 property 로 연결됨
    //outlet 은 객체의 속성, 즉 텍스트 내용이나 배경색 등을 변경할 때 사용ㅎ
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var sliderValue: UISlider!
    
    /*
     잘못 지정한 outlet 이나 action은 해당 코드를 지워주고 ui 에서도 우클릭 후 연결된걸 x 를 눌러서 직접 삭제.
     outlet 은 referencing outlet
     action 은 sent events
     */
    //버튼같이 눌러서 뭔가 바뀌는건 action으로 지정해야 함.
    //action 은 함수를 생성함. 또한 함수는 내가 수정할 수 있음
    //action은 method 로 연결됨
    @IBAction func showValue(_ sender: Any) {
    }

    
    //값이 바뀔때 자동으로 수행되는 동사. ~~할때 라는 이 조건은 어노테이션 함수 생성할 때 선택할 수 있음
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        titleLable.text=String(Int(sender.value))
        
    }
    
    
    
    //처음 한번만 실행해야 하는 초기화 코드는 여기서 작성//
    //뷰의 로딩이 완료되었을 때 시스템에 의해 자동으로 호출됨//
    //viewDidLoad 는 콜백 메소드임(적절한 시점에 시스템에서 자동으로 호출하는 함수)//
    //iOS는 특정 시점에 처리해줘야 할 작업이 있다면 대부분 우리가 그타임밍을 일일이 구현할 필요 없이 미리 정의되어 있는 메소드를 찾아 재정의하거나 코드 추가하면됨
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderValue.minimumValue=0
        sliderValue.maximumValue=100
        sliderValue.value=50
        sliderValue.isContinuous=false //값을 연속적으로 보내지 않게 함 = 슬라이더를 놓았을 때 값만 표출하게 됨
    }
    
    //View controller에서 새로운 view controller를 호출하여 화면 전환//
    @IBAction func clickMoveButton(_ sender: UIButton) {
        
        //변환할 vc를 지정 및 인스턴스화로 생성
        guard let presentVC = self.storyboard?.instantiateViewController(withIdentifier: "presentStoryboard")
                
        else {return}
        
        //vc 전환
        self.present(presentVC,  animated: true, completion: nil)
        print("페이지 이동")
    }
    
    //navigation controller를 이용한 화면 전환
    
    @IBAction func navigationMovebtn(_ sender: UIButton) {
        
        guard let presentVC = self.storyboard?.instantiateViewController(withIdentifier: "presentStoryboard")
        else {return}
        print("click")
        //스택에 화면 넣기
        self.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    
}

