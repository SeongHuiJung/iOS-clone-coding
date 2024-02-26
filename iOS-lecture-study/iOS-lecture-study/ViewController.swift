//
//  ViewController.swift
//  iOS-lecture-study
//
//  Created by 정성희 on 2024/02/05.
//

//data 넘기는 방법 6가지
//1. instance property
//2. segue
//3. instance 자체를 넘기기 (주소 포인터 개념) | self 를 줄테니 나에게 데이터를 줄때
//4. delegate(대리, 위임 의미함) pattern | self 를 줄테니 나에게 데이터를 줄때
//5. closure | 나에게 데이터를 줄때
//6. Notification
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationName = Notification.Name("sendSomeString")
    }
    
    //1. xib 데이터 넘기기//
    @IBAction func moveDetailVCXib(_ sender: Any) {
        
        //인스턴스 화
        let detailVC=DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        //이렇게 임시 변수를 통해 데이터를 보내주는 것이 가장 일반적.
        detailVC.someString="임시 변수를 통해 보낸 데이터"
        
        //화면에 올릴 준비를 해라 = 메모리에 올려라
        self.present(detailVC, animated: true, completion: nil)
        
        //self.present 후에는 label 값에 직접 접근할 수 있음. 왜냐? 메모리에 올라간 상태이기 때문
        detailVC.someLabel.text="레이블에 직접 보내는 데이터"
    }
    
    //2. segue 데이터 넘기기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue 은 한 vc에서 여러개 생성될 수 있다. 다만 모든 segue 가 실행될때마다 어떤게 어떤 segue 인지 모르기 때문에 if 절로 identifier 로 구분해줘야한다
        //detination 은 viewcontroller 타입이므로 타입캐스팅을 해줘야 하는데 SegueDetailViewController 으로 타입캐스팅할 수 있는지를 먼저 물어보고 된다면 그렇게 함.
        //destination 은 목적지로 향하는 vc를 가르킴
        if segue.identifier == "segueDetail" {
            if let detailVC = segue.destination as? SegueDetailViewController{
                detailVC.someString="segue 에서 보내는 데이터"
            }
        }
    }
    
    //3. instance 자체를 넘기기 (주소 포인터 넘기기)
    @IBOutlet weak var dataLabel: UILabel!
    @IBAction func moveToInstance(_ sender: Any) {
        let detailVC=InstanceDetailViewController(nibName: "InstanceDetailViewController", bundle: nil)
        //자기 자신을 넘겨줌 (포인터 주소인듯)
        detailVC.mainVC=self
        self.present(detailVC, animated: true)
    }
    
    //4. delegate(대리, 위임 의미함) pattern | self 를 줄테니 나에게 데이터를 줄때
    @IBAction func moveToDelegate(_ sender: Any) {
        let detailVC = DelegateDetailViewController(nibName: "DelegateDetailViewController", bundle: nil)
        
        //타입이 맞는 것만 연결해줌
        detailVC.delegate=self
        self.present(detailVC, animated: true)
    }
    
    //5. closure | 나에게 데이터를 줄때
    @IBAction func moveToClosure(_ sender: Any) {
        let detailVC = ClosureDetailViewController(nibName: "ClosureDetailViewController", bundle: nil)
        //body 를 여기서 만듬. str 은 받을 매개변수, in 다음이 구현부
        detailVC.myClosure = { str in
            self.dataLabel.text = str
        }
        self.present(detailVC, animated: true)
    }
    

    @IBAction func moveToThread(_ sender: Any) {
        let detailVC = ThreadDetailViewController(nibName: "ThreadDetailViewController", bundle: nil)
        self.present(detailVC, animated: true)
    }
}

//ViewController는 DelegateDetailViewController 를 준수하겠다고 선언. 이렇게 하는이유는 self 를 넘겨주려면 타입을 맞춰줘야 하기 때문. 마치 int 타입엔 int 값만 들어가야 하듯이
extension ViewController: DelegateDetailViewControllerDelegate{
    //사용하는 곳에서 프로토콜 바디를 만들어준다는 것이 이런것
    func passString(string: String) {
        dataLabel.text=string
    }
}

