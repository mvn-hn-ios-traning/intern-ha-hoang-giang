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
    func add(fraction1: Fraction, fraction2: Fraction) -> Result {
        let fraction3 = Result()
        fraction3.numerator   = fraction1.numerator   * fraction2.denominator + fraction1.denominator * fraction2.numerator
        fraction3.denominator = fraction1.denominator * fraction2.denominator
        return fraction3
    }
    
    func minus(fraction1: Fraction, fraction2: Fraction) -> Result{
        let fraction3 = Result()
        fraction3.numerator   = fraction1.numerator   * fraction2.denominator - fraction1.denominator * fraction2.numerator
        fraction3.denominator = fraction1.denominator * fraction2.denominator
        return fraction3
    }
    
    func multiply(fraction1: Fraction, fraction2: Fraction) -> Result {
        let fraction3 = Result()
        fraction3.numerator   = fraction1.numerator   * fraction2.numerator
        fraction3.denominator = fraction1.denominator * fraction2.denominator
        return fraction3
    }
    
    func divide(fraction1: Fraction, fraction2: Fraction) -> Result {
        let fraction3 = Result()
        fraction3.numerator   = obj1.numerator   * obj2.denominator
        fraction3.denominator = obj1.denominator * obj2.numerator
        return fraction3
    }
}

let obj1 = Result()
let obj2 = Result()
var obj3 = Result()
obj1.set(numerator: 5, denominator: 6)
obj2.set(numerator: 1, denominator: 2)
obj3 = obj3.add(fraction1: obj1, fraction2: obj2)
obj3.get()
obj3 = obj3.minus(fraction1: obj1, fraction2: obj2)
obj3.get()
obj3 = obj3.multiply(fraction1: obj1, fraction2: obj2)
obj3.get()
obj3 = obj3.divide(fraction1: obj1, fraction2: obj2)
obj3.get()
