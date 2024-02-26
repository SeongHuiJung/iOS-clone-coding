//
//  loginViewControl.swift
//  HelloSwiftProject
//
//  Created by 정성희 on 2024/02/02.
//

import Foundation
import UIKit
import Firebase
class loginViewControl: UIViewController {
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func loginBtn(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = Auth.auth().currentUser{
            emailTextField.placeholder = "이미 로그인 된 상태입니다"
            pwTextField.placeholder = "이미 로그인 된 상태입니다"
            
        }
         

    }
    
    @IBAction func clickLoginBtn(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: pwTextField.text!) { (user, error) in
            if user != nil {
                print("login success")
            }
            else{
                print("login fail")
            }
        }

        

    }
    
}
