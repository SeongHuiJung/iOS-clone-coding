//
//  ViewController.swift
//  TodoList
//
//  Created by 정성희 on 2024/02/27.
//

import UIKit
import CoreData

enum PriorityLevel: Int64 {
    case level1
    case level2
    case level3
}

//var priority : PriorityLevel
//priority 에 color 변수가 소속된 개념
//접근 : priority.color
extension PriorityLevel {
    var color: UIColor {
        switch self {
        case .level1:
            return .green
        case .level2:
            return .orange
        case .level3:
            return .red
        }
    }
}

class ViewController: UIViewController {
    //Appdelegate 클래스에 소속되어 있는 persistant container 를 사용하기 위해 appdelegate 생성
    // core data 는 주로 개발자가 context 를 통해 관리함
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    // 설정한 엔티티 이름을 자료형으로 쓸 수 있음
    var todoListData = [TodoList]()
    
    @IBOutlet weak var todoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        makeNavigationBar()
        
        //앱 실행 시 데이터 로드 됨
        fetchData()
        todoTableView.reloadData()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
    }
    
    @objc func addNewTodo() {
        let detailVC = TodoDetailVC.init(nibName: "TodoDetailVC", bundle: nil)
        //TodoDetailVC 에서 선언한 delegate 를 self 와 연결
        detailVC.delegate = self
        self.present(detailVC, animated: true)
    }
    
    // core data 불러오기
    func fetchData() {
        // 어디 있는 데이터를 불러 올 것인지 지정
        let fetchRequest :NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        let context = appdelegate.persistentContainer.viewContext
        
        do {
            self.todoListData = try context.fetch(fetchRequest)
        }catch{
            print(error)
        }
        
    }
    
    func makeNavigationBar() {
        // 네비게이션 제목 설정
        self.title = "To Do List"
        
        // 버튼 생성
        var item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTodo))
        
        // 네비게이션 오른쪽 부분에 버튼 넣기
        navigationItem.rightBarButtonItem = item
        
        // 네비게이션 색상 변경
        var barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .blue.withAlphaComponent(0.2)
        self.navigationController?.navigationBar.standardAppearance = barAppearance
        // iOS 15부터는 아래 코드까지 추가해야 배경색이 지정됨
        self.navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath) as! TodoListCell
        
        cell.topTitleLabel.text = todoListData[indexPath.row].title
        
        if let hasDate = todoListData[indexPath.row].date {
            let formatter = DateFormatter()
            formatter.dateFormat = "M월 d일 h:m:s"
            let dateString = formatter.string(from: hasDate)
            
            cell.dateLabel.text = dateString
        }
        //실패할 경우 빈 스트링으로 지정
        else {
            cell.dateLabel.text = ""
        }
        
        let priority = todoListData[indexPath.row].priority
        
        let priorityColor = PriorityLevel(rawValue: priority)?.color
        
        cell.priorityView.backgroundColor = priorityColor
        
        // 외곽선 둥글게
        cell.priorityView.layer.cornerRadius = cell.priorityView.bounds.height / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
}


extension ViewController : TodoDetailVCDelegate {
    // 구현부
    func didFinishSaveData() {
        // 데이터 불러오기
        self.fetchData()
        //화면 갱신
        self.todoTableView.reloadData()
    }
}
