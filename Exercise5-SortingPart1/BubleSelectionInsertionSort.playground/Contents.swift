import UIKit

//MARK: - Buble Sort
func makeBubleSort(_ array: [Int]) -> [Int] {
    var newArray = array
    let newArrayCounting = newArray.count
    
    for _ in 1..<newArrayCounting{
        for item in 0..<(newArrayCounting - 1) {
            if newArray[item] > newArray[item + 1] {
                newArray.swapAt(item, item + 1)
            }
        }
    }
    return newArray
}

//MARK: - Selection Sort
func makeSelectionSort(_ array: [Int]) -> [Int] {
    var newArray = array
    let newArrayCounting = newArray.count
    var current = 0
    
    while current < newArrayCounting - 1 {
        var lowest = current
        for item in (current + 1)..<newArrayCounting {
            if newArray[lowest] > newArray[item] {
                lowest = item
            }
        }
        if lowest != current {
            newArray.swapAt(lowest, current)
        }
        current += 1
    }
    return newArray
}

//MARK: - Insertion Sort
func makeInsertionSort(_ array: [Int]) -> [Int] {
    var newArray = array
    var newArrayCounting = newArray.count
    while newArrayCounting > 0 {
        for item in 1..<newArrayCounting{
            if newArray[item] < newArray[item - 1] {
                newArray.swapAt(item, item - 1)
            }
        }
        newArrayCounting -= 1
    }
    return newArray
}

//MARK: - Test 1: Reverse 1 array
func reverse(_ array: [Int]) -> [Int] {
    var newArray = array
    var leftIndex = 0
    var rightIndex = newArray.count - 1
    
    while leftIndex < rightIndex {
        newArray.swapAt(leftIndex, rightIndex)
        leftIndex += 1
        rightIndex -= 1
    }
    return newArray
}

var array = [5, 19, 15, 10, 1, 20]
print(array)
print(makeInsertionSort(array))
print(makeSelectionSort(array))
print(makeBubleSort(array))
print(reverse(array))
