//
//  ViewController.swift
//  iOS-setting-clone-app
//
//  Created by 정성희 on 2024/02/13.
//

import UIKit

class ViewController: UIViewController {
    
    var settingModel = [[SettingModel]]() //[[]] 이렇게 해주면 이중배열 구조

    func makeData(){
        settingModel.append(
        [SettingModel(leftImageName: "person.circle", menuTitle: "Sign in to your iPhone", subTitle: "Set up iCloud, the App Store, and more.", rightImageName: nil)]
        )
        
        settingModel.append(
        [SettingModel(leftImageName: "gear", menuTitle: "General", subTitle: nil, rightImageName: "chevron.right"),
        SettingModel(leftImageName: "person.fill", menuTitle: "Accessibility", subTitle: nil, rightImageName: "chevron.right"),
        SettingModel(leftImageName: "hand.raised.fill", menuTitle: "Privacy", subTitle: nil, rightImageName: "chevron.right")]
        )
        
    }
    
    @IBOutlet weak var settingTableView: UITableView!
    
    //화면 보여질때마다 실행
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //스크롤 내렸을 때 스크롤 제목이 위에 고정되게
        //navigationController은 한번 설정 해두면 다른 vc 가도 계속 유지됨
        //그래서 메인vc->다른vc 로 갔을때 메인과 다른 이 컨트롤러 설정이 다르다면 매번 화면 킬때마다 컨트롤러를 다시 설정해줘야함
        //다른vc 같은 경우는 계속 화면을 키게 되니까 viewDidLoad 에 해도 무관한데 메인vc 같은 경우는 viewDidLoad를 처음 앱 킬때 메모리를 불러오면서 한번 실행되기에 viewWillAppear 에서 실행함
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(white: 245/255, alpha: 1)
        
        //++ 해당 작업을 하는 이유 찾아보기
        settingTableView.delegate=self
        settingTableView.dataSource=self

        //xib파일 등록?
        let nib = UINib(nibName: "PrifileViewCell", bundle: nil)
        //현재 viewcontroller에서의 tableview에 nib 뷰를 추가
        settingTableView.register(nib, forCellReuseIdentifier: "PrifileViewCell")
        
        settingTableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        
        //섹션 별 구간 나눌때, table view 의 인스펙터에서 style 을 group 으로 바꾼 후 배경색을 지정하면 구간 별로 나눠주는 효과를 볼 수 있음
        settingTableView.backgroundColor = UIColor(white: 245/255, alpha: 1)
        
        makeData()
        
        //네비게이션 바 타이틀 제목넣기
        self.title = "Setting"
        
    }
}

//프로토콜을 준수해야함
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //필수, 셀 개수//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //섹션에서의 row 개수 리턴
        print("line: \(settingModel[section].count)")
        return settingModel[section].count
    }
    
    //섹션 수 리턴
    func numberOfSections(in tableView: UITableView) -> Int {
        settingModel.count
    }
    
    //필수, indexPath는 순서. 최종?적으로 출력해주는 곳//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //맨 첫번째 cell 의 경우 PrifileViewCell 를 보여줌
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrifileViewCell", for: indexPath) as! PrifileViewCell
            cell.topTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
            cell.profileImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
            cell.bottomDescription.text = settingModel[indexPath.section][indexPath.row].subTitle
            return cell
        }
        
        //나머지 cell 들의 경우 MenuCell 을 보여줌
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.leftImage.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
        cell.middleTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
        cell.rightImage.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].rightImageName ?? "")
        
        //아이콘 색상 변경
        cell.leftImage.tintColor = .red
        
        return cell
    
    }
    
    //셀 높이 지정 방법1 : 아래 함수 이용
    //셀 높이 지정 방법2는 이미지뷰 constrait 값을 위아래로 지정해주면됨
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    */
    
    //cell height 조정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            //기본값 그대로 출력하겠다는 의미
            return UITableView.automaticDimension
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell 한번 클릭하면 누른 표시가 그대로 유지 되기 때문에 누르고 바로 사라지게 하는 코드가 따로 필요함
        tableView.deselectRow(at: indexPath, animated: true)
        
        //섹션 1 에서의 0 번째 row cell 을 누를 경우
        if indexPath.section == 1 && indexPath.row == 0 {
            //UIStoryboard -> name 이름의 스토리보드에서
            //instantiateViewController -> withIdentifier 이름을 가진 vc 를 가져오라는 의미
            if let generalVC = UIStoryboard(name: "GeneralViewController", bundle: nil).instantiateViewController(withIdentifier: "GeneralViewController") as? GeneralViewController {
                //현재 navigation view controller 기반임
                //그렇다면 눌렀을때 이동하는것을 내비게이션 이동을 할 수 있는 형태를 받을 수 있음
                //눌렀을때 generalVC로 이동하겠다는 의미임
                print("클릭")
                self.navigationController?.pushViewController(generalVC, animated: true)
            }
            //as? -> 타입 캐스팅 가능할시 캐스팅 하겠다
            //as! -> 타입 캐스팅 강제로 실행
        }
        else if indexPath.section == 1 && indexPath.row == 1 {
            let myidVC = MyIDViewController(nibName: "MyIDViewController", bundle: nil)
            self.present(myidVC, animated: true)
            }
        }
}

