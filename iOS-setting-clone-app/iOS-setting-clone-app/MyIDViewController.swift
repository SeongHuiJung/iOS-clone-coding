//
//  MyIDViewController.swift
//  iOS-setting-clone-app
//
//  Created by 정성희 on 2024/02/15.
//

import UIKit

class MyIDViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!{
        didSet{ //여기서 초기화를 해주는건 좀 고민해 봐야 할 필요가 있음
            nextButton.isEnabled = false
        }
    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func doCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 입력필드에 입력시
        // target: Any? 는 실행되야 할 함수를 어디서 찾을건지 적는곳
        //action: 은 어떤 함수를 찾을 건지
        //for: 은 어떤 행위가 감지됐을때 함수를 실행하겠다. 주로 .editingChanged 를 많이씀
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    //selector 안에 넣기 위해선 @objc 를 추가해 줘야함
    //-> 왜?
    @objc func textFieldDidChange(sender: UITextField) {
        print(sender.text ?? "") //?? "" 는 값이 없을 경우 "" 를 출력하겠다는 의미
        
        //현재 입력된 글자가 없다면
        if(sender.text?.isEmpty == true) {
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
        }
    }

}
