import UIKit

//MARK: - Buble Sort
func bubleSort(_ array: [Int]) -> [Int] {
    var newArray = array
    
    for _ in 1..<array.count{
        for x in 0..<array.count-1 {
                if newArray[x] > newArray[x+1] {
                    newArray.swapAt(x, x+1)
                }
        }
    }
    return newArray
}

//MARK: - Selection Sort
func selectionSort(_ array: [Int]) -> [Int] {
    var newArray = array
    var n = 0
    
    while n < newArray.count-1 {
        var lowest = n
        for x in (n+1)..<newArray.count{
            if newArray[lowest] > newArray[x] {
                lowest = x
            }
        }
        if lowest != n {
            newArray.swapAt(lowest, n)
        }
        n += 1
    }
    return newArray
}

//MARK: - Insertion Sort
func insertionSort(_ array: [Int]) -> [Int] {
    var newArray = array
    var n = newArray.count
    while n > 0 {
        for x in 1..<n{
            if newArray[x] < newArray[x-1] {
                newArray.swapAt(x, x-1)
            }
        }
        n -= 1
    }
    return newArray
}

//MARK: - Test 1: Reverse 1 array
func reverse(_ array: [Int]) -> [Int] {
    var newArray = array
    var left = 0
    var right = newArray.count - 1
    
    while left < right {
        newArray.swapAt(left, right)
        left += 1
        right -= 1
    }
    return newArray
}

var array = [5, 19, 15, 10, 1, 20]
print(array)
print(insertionSort(array))
print(selectionSort(array))
print(bubleSort(array))
print(reverse(array))
