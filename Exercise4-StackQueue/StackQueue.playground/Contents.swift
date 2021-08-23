import Foundation

struct Stack<Element> {
    var array: [Element] = []
    
    mutating func push(_ element: Element) {
        array.append(element)
    }
    
    mutating func pop() -> Element? {
        return array.popLast()
    }
    
    func peek() -> Element? {
        return array.last
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        let topDivider = "---Stack--- \n"
        let bottomDevider = "\n ------ \n"
        let stackElements = array.map{"\($0)"}.reversed().joined(separator: "\n")
        return topDivider + stackElements + bottomDevider
    }
}

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

struct QueueArray<T>: Queue {
    private var array: [T] = []
    init() {}
    
    var isEmpty: Bool {
        array.isEmpty
    }
    var peek: T? {
        array.first
    }
    
    mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
}

extension QueueArray: CustomStringConvertible {
    public var description: String {
        String(describing: array)
    }
}

extension QueueArray {
    func reversed() -> QueueArray {
        var queue = self
        var stack = Stack<T>()
        
        while let element = queue.dequeue() {
            stack.push(element)
        }
        while let element = stack.pop() {
            queue.enqueue(element)
        }
        
        return queue
    }
}

var queue = QueueArray<String>()
queue.enqueue("1")
queue.enqueue("21")
queue.enqueue("18")
queue.enqueue("42")
print("before: \(queue)")
print("after: \(queue.reversed())")
