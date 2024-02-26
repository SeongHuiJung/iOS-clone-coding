

import Foundation
var cnt = 0
solution(4,1,[1,2,3,4])

func solution(_ n:Int, _ m:Int, _ section:[Int]) -> Int {
    var startIdx = 0

    for i in 0...section.count-2 {
        check(m: m ,section : section, currentIdx: i, checkIdx: i+1)
    }
    print(cnt)
    return 0
}

func check(m: Int ,section : [Int], currentIdx: Int , checkIdx: Int){
    if (checkIdx < section.count) {
        if (section[currentIdx] + m - 1 > section[checkIdx]){
            cnt += 1
            check(m: m ,section : section, currentIdx: currentIdx, checkIdx: checkIdx+1)
            }
        else if (section[currentIdx] + m - 1 == section[checkIdx]) {
            cnt += 1
        }
    }
}
