//
//  SecondViewController.swift
//  HelloSwiftProject
//
//  Created by 정성희 on 2024/01/25.
//

import Foundation
import UIKit

final class SecondViewController: UIViewController {
    var someData=""
    //View controller에서 새로운 view controller를 호출하여 화면 전환//
    @IBAction func clickBackbtn(_ sender: UIButton) {
        self.dismiss(animated:  true)
    }
    
    
    //navigation controller를 이용한 화면 돌아가기//
    @IBAction func navigationBackbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLabelText()
        print("앱시작")
    }
    
    
    @IBAction func IBInpectorMoveBtn(_ sender: Any) {
        guard let presentVC = self.storyboard?.instantiateViewController(withIdentifier: "IBInspectarableVC")
        else {return}
        
        //vc 전환
        self.present(presentVC,  animated: true, completion: nil)
        
    }
    
    
    //알림창 띄우고 알림창에서 입력한 데이터 이전 페이지의 라벨로 옮기기//
    @IBOutlet weak var alertLabel: UILabel!
    @IBAction func ClickAlertBtn(_ sender: Any) {
        let alert = UIAlertController(title: "메세지 입력", message: "test", preferredStyle: .alert)
                
                let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                let okButton = UIAlertAction(title: "입력", style: .default, handler: { [weak self] _ in
                    guard let text = alert.textFields?[0].text else { return }
                    self?.labelText=text
                    self?.alertLabel.text = text
                
                })
        alert.addTextField(configurationHandler: {UITextField in UITextField.placeholder = "메시지를 입력하세요."})
        
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        
        self.present(alert,animated: true, completion: nil)
    }
    
    var labelText: String? {
        didSet{ //이 didset의 용도는 무엇이며 언제 호출?? 되는가? 공부할것
            self.saveLabelText()
        }
    }
    //사용자 정보 저장
    private func saveLabelText(){
        let userDefaults=UserDefaults.standard
        userDefaults.set(self.labelText, forKey: "labelText")
    }
    
    //앱종료 후 재실행 시 사용자 정보 데이터 로드
    private func loadLabelText(){
        
        let userDefaults=UserDefaults.standard
        
        guard let data = userDefaults.object(forKey: "labelText") as? String else {return}
        print("load")
        self.alertLabel.text=data
        
    }
     
    
   
    /*
    @IBAction func clickChangeTxt(_ sender: Any) {
        alertLabel.text="abc"
        labelText="abc"
    }
    
    
    private func saveLabelData(){
        let userDefaults=UserDefaults.standard
        userDefaults.set(self.labelText, forKey: "text")
    }
    
    private func loadLabelData(){
        let userDefaults=UserDefaults.standard
        guard let data = userDefaults.object(forKey: "text") as? String else {return}
        self.alertLabel.text=data
    }
     */
}
