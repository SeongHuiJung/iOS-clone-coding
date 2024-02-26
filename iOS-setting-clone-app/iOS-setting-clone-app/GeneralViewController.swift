//
//  GeneralViewController.swift
//  iOS-setting-clone-app
//
//  Created by 정성희 on 2024/02/15.
//

import UIKit

//새로운 스토리보드 생성하는 방식

//하나의 swift 파일에 클래스 두개를 넣는 것은 매우 흔하지는 않음
//아래 cell 이 generalvc에 무조건 종속적인 것이라면 이렇게 할수도 있긴 함
//이렇게 할 경우 register 를 뛰어넘어도 됨
class GeneralCell: UITableViewCell {
    
    @IBOutlet weak var rightImageView: UIImageView! {
        //property observer 개념
        //메모리에 잡히거나 값이 변경될 때 호출됨
        //인스턴스화라고 생각하면 된다고 했는데 좀더 자세히 알아볼것
        //xib 랑 연결돼서 객체가 생성되는 시점에 호출됨
        //rightImageView 같은 ui 는 여기가 시작점이라고 생각해도 무방
        didSet {
            rightImageView.image = UIImage(systemName: "chevron.right")
            rightImageView.backgroundColor = .clear // 투명
        }
    }
    @IBOutlet weak var leftLabel: UILabel!
}

struct generalModel {
    var leftTitle: String = ""
    
}



//ViewController 에서는 프로토콜을 extension 으로 따로 빼줬지만 이렇게 할 수도 있음
class GeneralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model = [[generalModel]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralCell", for: indexPath) as! GeneralCell
        cell.leftLabel.text = model[indexPath.section][indexPath.row].leftTitle
        
        return cell
    }
    
    func makedata() {
        model.append([generalModel(leftTitle: "About")])
        
        model.append(
        [generalModel(leftTitle: "Keyboard"),
        generalModel(leftTitle: "Game Controller"),
        generalModel(leftTitle: "Fonts"),
        generalModel(leftTitle: "Language & Region"),
        generalModel(leftTitle: "Dictionary")]
        )
        
        model.append([generalModel(leftTitle: "Reset")])
        
    }
    
    
    @IBOutlet weak var generalTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        generalTableView.delegate = self
        generalTableView.dataSource = self
        generalTableView.backgroundColor = UIColor(white: 244/255, alpha: 1)
        
        self.title = "General"
        //navigationController은 한번 설정 해두면 다른 vc 가도 계속 유지됨
        //그래서 메인vc->다른vc 로 갔을때 메인과 다른 이 컨트롤러 설정이 다르다면 매번 화면 킬때마다 컨트롤러를 다시 설정해줘야함
        //다른vc 같은 경우는 계속 화면을 키게 되니까 viewDidLoad 에 해도 무관한데 메인vc 같은 경우는 viewDidLoad를 처음 앱 킬때 메모리를 불러오면서 한번 실행되기에 다른 방법을 사용해야함
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        makedata()
    }
    

}
