import UIKit

protocol Shape {
    func area() -> Float
    func perimeter() -> Float
}

class Circle: Shape {
    var radius: Float
    
    init(_ radius: Float) {
        self.radius = radius
    }
    func area() -> Float {
        return radius*radius*3.14
    }
    func perimeter() -> Float {
        return radius*2*3.14
    }
}

class Square: Shape {
    var lengthOfSide: Float
    
    init(_ lengthOfSide: Float) {
        self.lengthOfSide = lengthOfSide
    }
    
    func area() -> Float {
        return lengthOfSide*lengthOfSide
    }
    
    func perimeter() -> Float {
        return lengthOfSide*4
    }
}

class Retangle: Shape {
    var width: Float
    var height: Float
    
    init(_ width: Float, _ height: Float) {
        self.width = width
        self.height = height
    }
    
    func area() -> Float {
        return width*height
    }
    
    func perimeter() -> Float {
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

let cirle1      = Circle(5.0)
let circle2     = Circle(7.5)
let square1     = Square(8.5)
let square2    = Square(10.0)
let retangle1   = Retangle(5.0, 8.5)
let retangle2   = Retangle(1.0, 7.5)

//var shapes  = [cirle1, circle2]
//var shapes = [square1, square2]
var shapes = [retangle1, retangle2]
let total   = Total(shapes)
total.sum()
