import UIKit

//MARK: - Stack
struct Stack {
    var array:[Int] = [Int]()
    
    mutating func push(_ element: Int) {
        array.append(element)
    }
    
    mutating func pop() -> Int? {
        return array.popLast()
    }
    
    func peek() -> Int? {
        return array.last
    }
}

var myArray = Stack()
myArray.push(0)
myArray.push(1)
myArray.push(2)
myArray.peek()
print(myArray)
myArray.pop()
print(myArray)

//MARK: - Queue
struct Queue {
    var array = [String]()
    
    mutating func enqueue(_ element: String) {
        array.append(element)
    }
    
    mutating func dequeue() -> String? {
        return array.isEmpty ? nil : array.removeFirst()
    }
    
    func peek() -> String? {
        return array.isEmpty ? nil : array.last 
    }
    
    mutating func nextPlayer() -> String? {
        guard let person = dequeue() else { return nil }
        enqueue(person)
        return person
    }
}

var myTurn = Queue()
//myTurn.enqueue("Giang")
//myTurn.enqueue("Hoang")
//myTurn.enqueue("Ha")
myTurn.peek()
print(myTurn)
myTurn.nextPlayer()
print(myTurn)
myTurn.nextPlayer()
print(myTurn)
myTurn.nextPlayer()
print(myTurn)

