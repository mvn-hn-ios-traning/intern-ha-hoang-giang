import UIKit

//MARK: - Buble Sort
/// Buble Sort: So sánh lần lượt các phần tử trong mảng từ trái qua phải liên tiếp nhau, ví dụ index n với index (n + 1), nếu cặp so sánh nào thoả mãn điều kiện thì swap 2 index đó
/// Sau mỗi lần lặp thì giá trị ở index cuối cùng (giảm dần, -1 sau mỗi lần lặp) sẽ luôn thoả mãn
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
/// Selection Sort: Coi phần tử đầu tiên index 0 là tiêu chuẩn, so sánh phần tử đầu tiên với từng giá trị trong mảng, nếu có phần tử nào khác thoả mãn hơn thì thay thế tiêu chuẩn bằng phần tử đó
/// phần tử thoả mãn điều kiện cuối cùng sẽ được swap với phần tử đầu tiên index 0
/// sau mỗi lần lặp sẽ tăng giá trị phần tử đầu tiên lên 1 (index 0 -> index 1 -> index 2 ...)
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
/// Insertion Sort: So sánh các phần tử với tất cả phần tử bên trái của nó (do đó phần tử đầu tiên sẽ được bỏ vì không có phần tử bên trái)
/// Nếu thoả mãn điều kiện thì swap, nếu không thoả mãn thì break vòng lặp (break sẽ tiết kiệm số lần lặp)
func makeInsertionSort(_ array: [Int]) -> [Int] {
    var newArray = array
    var current = 0
    
    while current < (newArray.count - 1) {
        var new = current + 1
        while new > 0 {
            if newArray[new] < newArray[new - 1] {
                newArray.swapAt(new, new - 1)
                new -= 1
            } else {
                break
            }
        }
        current += 1
    }
    return newArray
}

//MARK: - Test 1: Reverse 1 array
func reverse(_ array: [Int]) -> [Int] {
    var newArray = array
    var leftIndex = 0
    var rightIndex = newArray.count - 1
    
    for _ in 0..<(newArray.count / 2) {
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
