import UIKit

class Shape {
    func area() -> Float {
        return 0
    }
    
    func perimeter() -> Float {
        return 0
    }
}

class Circle: Shape {
    var radius: Float
    
    init(_ radius: Float) {
        self.radius = radius
    }
    override func area() -> Float {
        return radius*radius*3.14
    }
    override func perimeter() -> Float {
        return radius*2*3.14
    }
}

class Square: Shape {
    var lengthOfSide: Float
    
    init(_ lengthOfSide: Float) {
        self.lengthOfSide = lengthOfSide
    }
    
    override func area() -> Float {
        return lengthOfSide*lengthOfSide
    }
    
    override func perimeter() -> Float {
        return lengthOfSide*4
    }
}

class Retangle: Shape {
    var width: Float
    var height: Float
    
    init(width: Float, height: Float) {
        self.width = width
        self.height = height
    }
    
    override func area() -> Float {
        return width*height
    }
    
    override func perimeter() -> Float {
        return (width+height)*2
    }
}

class Total {
    let shapes: [Shape]
    
    init(_ shapes: [Shape]) {
        self.shapes = shapes
    }
    
    func sum() -> Float {
        var sum: Float = 0.0
        for shape in shapes {
            sum += shape.area()+shape.perimeter()
        }
        return sum
    }
}

let circle1     = Circle(5.0)
let circle2     = Circle(7.5)
let square1     = Square(8.5)
let square2     = Square(10.0)
let retangle1   = Retangle(width: 5.0, height: 8.5)
let retangle2   = Retangle(width: 1.0, height: 7.5)

let shapes  = [circle1, square2, retangle2]
let total   = Total(shapes)
total.sum()
