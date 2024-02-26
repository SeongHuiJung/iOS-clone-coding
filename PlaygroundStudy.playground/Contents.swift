import UIKit //UIKit 프레임워크를 임포트
import MapKit

var greeting = "Helo, playgrdsssdound"
print(greeting)

UIImage(systemName: "star")

var sum = 0
for i in 1...10 {
    sum+=i
}
print (sum)

//dump 가 더 자세한 내용을 출력
dump(greeting)

var str :String = String(("I am a student.".split(separator: " "))[0])

print(str) // I

var str2 :[Substring] = ("I am a student.".split(separator: " "))
type(of: str2)


var test : Int?
test
test=1
test
print(test!)
var gift_record = [[Int]](repeating: [Int](repeating: 0, count: 10), count: 10)


print(gift_record)

gift_record[0][0]=1
//gift_record.insert([1,1], at: 1)


print(gift_record)

var ss = [[1,2,3],[9,9,9]]
test(list : &ss)
print(ss)
func test (list :inout [[Int]]) {
    list[1][1]=10
}
