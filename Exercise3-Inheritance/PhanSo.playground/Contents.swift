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
        fraction3.numerator   = fraction1.numerator   * fraction2.denominator
        fraction3.denominator = fraction1.denominator * fraction2.numerator
        return fraction3
    }
}

let object1 = Result()
let object2 = Result()
var object3 = Result()
object1.set(numerator: 5, denominator: 6)
object2.set(numerator: 1, denominator: 2)
object3 = object3.add(fraction1: object1, fraction2: object2)
object3.get()
object3 = object3.minus(fraction1: object1, fraction2: object2)
object3.get()
object3 = object3.multiply(fraction1: object1, fraction2: object2)
object3.get()
object3 = object3.divide(fraction1: object1, fraction2: object2)
object3.get()
