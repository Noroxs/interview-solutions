import UIKit

let numberArray = [1, 3, 5, -2, 1, 5, 11]

// in -> [1, 3, 5, -2, 1, 5, 11]
// out -> [1:2, 3:1, 5:2, -2:1, 11:1]
func analyzeArray(_ array: [Int]) -> [Int: Int] {

    return numberArray.reduce(into: [Int: Int]()) { $0[$1, default: 0] += 1 }
}

// in -> [1:2, 3:1, 5:2, -2:1, 11:1]
// in -> [5:2, 1:2, 11:1, 3:1, -2:1]
func sortAnalyzedDictionary(_ dictionary: [Int: Int]) -> [(key: Int, value: Int)] {
    
    return dictionary.sorted { lhs, rhs in
        if lhs.value != rhs.value {
            return lhs.value > rhs.value
        } else {
            return lhs.key > rhs.key
        }
    }
}

func printSortedNumbers(_ sortedNumbers: [(key: Int, value: Int)]) {
    
    sortedNumbers.forEach { print("\($0)\t - \t\($1)") }
}

let dictionary = analyzeArray(numberArray)
let sortedNumbers = sortAnalyzedDictionary(dictionary)
printSortedNumbers(sortedNumbers)
