import UIKit

class Fraction {
    var numerator: Int
    var denominator: Int
    
    init() {
        self.numerator   = 0
        self.denominator = 1
    }
    
    func set(numerator: Int, denominator: Int) {
        self.numerator   = numerator
        self.denominator = denominator
    }
    
    func get() {
        print("\(numerator)/\(denominator)")
    }
}

class Result: Fraction {
    func add(obj1: Fraction, obj2: Fraction) -> Result {
        let obj3 = Result()
        obj3.numerator   = obj1.numerator   * obj2.denominator + obj1.denominator * obj2.numerator
        obj3.denominator = obj1.denominator * obj2.denominator
        return obj3
    }
    
    func minus(obj1: Fraction, obj2: Fraction) -> Result{
        let obj3 = Result()
        obj3.numerator   = obj1.numerator   * obj2.denominator - obj1.denominator * obj2.numerator
        obj3.denominator = obj1.denominator * obj2.denominator
        return obj3
    }
    
    func multiply(obj1: Fraction, obj2: Fraction) -> Result {
        let obj3 = Result()
        obj3.numerator   = obj1.numerator   * obj2.numerator
        obj3.denominator = obj1.denominator * obj2.denominator
        return obj3
    }
    
    func divide(obj1: Fraction, obj2: Fraction) -> Result {
        let obj3 = Result()
        obj3.numerator   = obj1.numerator   * obj2.denominator
        obj3.denominator = obj1.denominator * obj2.numerator
        return obj3
    }
}

let obj1 = Result()
let obj2 = Result()
var obj3 = Result()
obj1.set(numerator: 5, denominator: 6)
obj2.set(numerator: 1, denominator: 2)
obj3 = obj3.add(obj1: obj1, obj2: obj2)
obj3.get()
obj3 = obj3.minus(obj1: obj1, obj2: obj2)
obj3.get()
obj3 = obj3.multiply(obj1: obj1, obj2: obj2)
obj3.get()
obj3 = obj3.divide(obj1: obj1, obj2: obj2)
obj3.get()
