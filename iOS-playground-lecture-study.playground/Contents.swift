import UIKit

let names = ["apple","banana","pencil","pineapple"]

let containsSomeText: (String, String) -> Bool = {name, find in
    if name.contains(find) {return true}
    return false
}

func find(findString: String, condition: (String, String) -> Bool ) ->  [String]{
    var newNames=[String]()
    for name in names{
        if condition(name, findString) {
            newNames.append(name)
        }
    }
    return newNames
}

find(findString: "a", condition: containsSomeText)
