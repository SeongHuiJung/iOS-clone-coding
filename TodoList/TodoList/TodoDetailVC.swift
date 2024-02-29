//
//  TodoDetailVC.swift
//  TodoList
//
//  Created by 정성희 on 2024/02/27.
//

import UIKit
import CoreData

// 프로토콜 선언부
protocol TodoDetailVCDelegate: AnyObject{
    func didFinishSaveData()
}

class TodoDetailVC: UIViewController {
    
    weak var delegate : TodoDetailVCDelegate?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var lowButton: UIButton!
    
    @IBOutlet weak var normalButton: UIButton!
    
    @IBOutlet weak var highLabel: UIButton!
    
    var priority: PriorityLevel?
    
    //하나의 IBAction 에 여러 reference를 연결했을 때 구분하는 방법으로 sender 를 UIButton로 해주고 태그로 분류함
    @IBAction func setPriority(_ sender: UIButton) {
        
        lowButton.backgroundColor = .clear
        normalButton.backgroundColor = .clear
        highLabel.backgroundColor = .clear

        switch sender.tag {
        case 1:
            priority = .level1
            lowButton.backgroundColor = priority?.color
            break
        case 2:
            priority = .level2
            normalButton.backgroundColor = priority?.color
            break
        case 3:
            priority = .level3
            highLabel.backgroundColor = priority?.color
            break
        default:
            break
        }
    }
    
    
    @IBAction func saveTodo(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TodoList", in: context) else { return }
        
        // key-value 형태로 데이터를 가져옴
        // TodoList 형태로 바꿀 수 있다면 바꾸고 나서 그대로 진행
        guard let object = NSManagedObject(entity: entityDescription, insertInto: context)as? TodoList else {
            return
        }
        
        object.title = titleTextField.text
        object.uuid = UUID()
        //현재시간
        object.date = Date()
        
        object.priority = priority?.rawValue ?? PriorityLevel.level2.rawValue
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 저장
        appDelegate.saveContext()
        
        // 데이터 저장 후 리로드
        delegate?.didFinishSaveData()
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lowButton.layer.cornerRadius = lowButton.bounds.height / 2
        normalButton.layer.cornerRadius = normalButton.bounds.height / 2
        highLabel.layer.cornerRadius = highLabel.bounds.height / 2
    }

}
