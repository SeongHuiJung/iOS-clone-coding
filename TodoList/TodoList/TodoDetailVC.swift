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
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var priority: PriorityLevel?
    
    var selectedTodoList: TodoList? //core data 형, 리스트에서 내가 선택한걸 보내줌
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //하나의 IBAction 에 여러 reference를 연결했을 때 구분하는 방법으로 sender 를 UIButton로 해주고 태그로 분류함
    @IBAction func setPriority(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            priority = .level1
            break
        case 2:
            priority = .level2
            break
        case 3:
            priority = .level3
            break
        default:
            break
        }
        
        makePriorityDesign()
    }
    
    // 버튼 클릭시 디자인 변환하는 함수
    func makePriorityDesign() {
        lowButton.backgroundColor = .clear
        normalButton.backgroundColor = .clear
        highLabel.backgroundColor = .clear
        
        switch priority {
        case .level1:
            lowButton.backgroundColor = priority?.color
            break
        case .level2:
            normalButton.backgroundColor = priority?.color
            break
        case .level3:
            highLabel.backgroundColor = priority?.color
            break
        default:
            break
        }
    }
    
    // 현재 값 저장
    @IBAction func saveTodo(_ sender: Any) {
        // 선택해서 불러온 값이 있을 때 = update
        if selectedTodoList != nil {
            updateTodo()
        }
        // 새로운 값 저장
        else {
            saveTodo()
        }
        
        // 데이터 저장 후 리로드
        delegate?.didFinishSaveData()
        self.dismiss(animated: true)
    }
    
    // 새로운 데이터 저장
    func saveTodo() {
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
        

    }
    
    // 데이터 수정
    func updateTodo() {
        guard let hasData = selectedTodoList else{return}
        guard let hasUUID = hasData.uuid else {return}
        
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        
       
        do{
            //context 를 통해 fetchRequst 에 걸려있는 조건을 토대로 todolist를 가져옴
            let loadedData = try context.fetch(fetchRequest)
            
            // predicate 로 정한 조건의 데이터가 여러개 있을 수 있으므로 array 로 불러와짐. uuid 로 불러오므로 무조건 하나만 있다고 확신할 수 있어서 first 키워드 사용
            loadedData.first?.title = titleTextField.text
            loadedData.first?.date = Date()
            loadedData.first?.priority = priority?.rawValue ?? PriorityLevel.level1.rawValue
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            // 저장
            appDelegate.saveContext()
        }catch{
            print(error)
        }
    }
    
    // 데이터 삭제
    @IBAction func deleteTodo(_ sender: UIButton) {
        guard let hasData = selectedTodoList else{return}
        guard let hasUUID = hasData.uuid else {return}
        
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        
        //context 를 통해 fetchRequst 에 걸려있는 조건을 토대로 todolist를 가져옴
        do{
            let loadedData = try context.fetch(fetchRequest)
            
            if let loadFirstData = loadedData.first {
                // 데이터 삭제
                // delete 까지 하고 저장까지 해줘야함. context.delete 만 하면 메모리에서만 삭제하는 거라 앱 종료 후 재실행 하면 다시 생김
                context.delete(loadFirstData)
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                // 저장
                appDelegate.saveContext()
            }
        }catch{
            print(error)
        }
        
        // 데이터 변경 후 리로드
        delegate?.didFinishSaveData()
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 기존에 있던 데이터 선택시 보여줄 화면에 데이터 넣기
        if let hasData = selectedTodoList {
            titleTextField.text = hasData.title
            priority = PriorityLevel(rawValue: hasData.priority)
            makePriorityDesign()
            
            deleteButton.isHidden = false
            
            saveButton.setTitle("Update", for: .normal)
        }
        else {
            // 새로운 데이터 생성하는 경우에는 삭제 버튼이 필요 없으므로 보이지 않게 설정
            deleteButton.isHidden = true
            
            saveButton.setTitle("Save", for: .normal)

        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lowButton.layer.cornerRadius = lowButton.bounds.height / 2
        normalButton.layer.cornerRadius = normalButton.bounds.height / 2
        highLabel.layer.cornerRadius = highLabel.bounds.height / 2
    }

}
