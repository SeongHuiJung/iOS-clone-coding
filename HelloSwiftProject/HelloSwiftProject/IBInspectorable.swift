//
//  IBInspectorable.swift
//  HelloSwiftProject
//
//  Created by 정성희 on 2024/01/29.
//
//import Foundation
import UIKit

@IBDesignable
class IBInspectorable: UIView{
    @IBInspectable var borderWIdth: CGFloat{
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth=newValue
        }
    }
}


 class BackClass: UIViewController{
 
 @IBAction func BackBtn(_ sender: Any) {
 print("click")
 self.dismiss(animated: true)
 }
 
 @IBAction func test(_ sender: Any) {
 print("click2")
 self.dismiss(animated: true)
 }
 
 override func viewDidLoad() {
 super.viewDidLoad()
 }
 
 }
 



