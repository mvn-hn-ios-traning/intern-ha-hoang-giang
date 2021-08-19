import UIKit


/* Exercise 1: Create a new Employee class with a custom initializer that requires two string arguments: firstName and lastName. Use the arguments to initialize properties with the same names as the arguments. Display a message with the values for firstName and lastName when an instance of the class is created. Display a message with the values for firstName and lastName when an instance of the class is destroyed.
    Create an instance of the Employee class and assign it to a variable. Check the messages printed in the Playground's Debug area. Assign a new instance of the Employee class to the previously defined variable. Check the messages printed in the Playground's Debug area. */

class Employee {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func isDestroyed() -> String {
        
        return "\(firstName) \(lastName) destroyer"
    }
    
    func isCreated() -> String {
        
        return "\(firstName) \(lastName) creater"
    }
    
}

let employee = Employee(firstName: "Hoang", lastName: "Giang")
employee.isCreated()
employee.isDestroyed()



/* Exercise 2: Create a function that receives two string arguments: firstName and lastName. Create an instance of the previously defined Employee class with the received arguments as parameters for the creation of the instance. Use the instance properties to print a message with the first name followed by a space and the last name. You will be able to create a method and add it to the Employee class later to perform the same task. However, first, you must understand how you can work with the properties defined in a class.  */

