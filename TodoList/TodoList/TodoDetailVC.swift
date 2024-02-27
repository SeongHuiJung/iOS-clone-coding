//
//  TodoDetailVC.swift
//  TodoList
//
//  Created by 정성희 on 2024/02/27.
//

import UIKit
import CoreData

class TodoDetailVC: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var lowButton: UIButton!
    
    @IBOutlet weak var normalButton: UIButton!
    
    @IBOutlet weak var highLabel: UIButton!
    
    //하나의 IBAction 에 여러 reference를 연결했을 때 구분하는 방법으로 sender 를 UIButton로 해주고 태그로 분류함
    @IBAction func setPriority(_ sender: UIButton) {

        switch sender.tag {
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        guard var entityDescription = NSEntityDescription.entity(forEntityName: "TodoList", in: context) else { return }
        
        // key-value 형태로 데이터를 가져옴
        // TodoList 형태로 바꿀 수 있다면 바꾸고 나서 그대로 진행
        guard let object = NSManagedObject(entity: entityDescription, insertInto: context)as? TodoList else {
            return
        }
        
        object.title = titleTextField.text
        object.uuid = UUID()
        //현재시간
        object.date = Date()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 저장
        appDelegate.saveContext()
        
        self.dismiss(animated: true)
    }


}
