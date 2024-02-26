//
//  ThreadDetailViewController.swift
//  iOS-lecture-study
//
//  Created by 정성희 on 2024/02/09.
//

import UIKit

class ThreadDetailViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.timeLabel.text = Date().timeIntervalSince1970.description
        }
    }

    @IBAction func action1(_ sender: Any) {
        simpleClosure {
            self.finishLabel.text="끝"
        }
    }
    
    func simpleClosure(completion: @escaping ()->Void) {
        DispatchQueue.global().async {
            for i in 0...10{
                Thread.sleep(forTimeInterval: 0.2)
                print(i)
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    @IBAction func action2(_ sender: Any) {
        let dispatchGroup = DispatchGroup()
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
        let queue3 = DispatchQueue(label: "q3")
    
        //만약 하나의 디스패치 큐로 async를 세번 한다면 async의 역할을 하지 못하고 sync 역할을 할 것임. 제대로 async로 돌리고 싶다면 일 개수 만큼의 큐를 이어줄것
        queue1.async(group: dispatchGroup) {
            for i in 0...10{
                Thread.sleep(forTimeInterval: 0.2)
                print(i)
            }
        }
        queue2.async(group: dispatchGroup) {
            for i in 10...20{
                Thread.sleep(forTimeInterval: 0.2)
                print(i)
            }
        }
        queue3.async(group: dispatchGroup) {
            for i in 20...30{
                Thread.sleep(forTimeInterval: 0.2)
                print(i)
            }
        }
        
        //notify 는 그룹에 들어 있는 스레드들이 모든 작업을 다 끝내면 (모든 스레드가 큐에 들어 있는 작업이 더 이상 없으면) 실행함
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("끝")
        }
    }
    
}
