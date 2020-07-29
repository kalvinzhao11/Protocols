import UIKit

// These are the rules for anyone that wants to have a full name.
protocol FullyNamed {
    var fullName: String {get} //can it be get only?  or can it be get set {get set}
    
}

// Getters and Setters

var isOverFifty = false

// Get-only properties are also called computed properties
var randomNumber: Int  {
    get {
        print("Getting the value of ranodmNumber")
        return Int.random(in: 1...100)
    }
    // This setter will run when you try to set the value of randomNumber (using = )
    set {
//        print("The value is being set to \(newValue)")
        if newValue > 50 {
            isOverFifty = true
        } else {
            isOverFifty = false
        }
    }
}

print(randomNumber)
print(randomNumber)
print(randomNumber)

// getter = use or read value, like the print statement

// setter, Ex: randomNumber = 40
randomNumber = 51
// This is set to newValue in the setter
print(isOverFifty)



// Person is adopting the protocol FullyNamed, its not of type FullyNamed
struct Person: FullyNamed {
    
    // This is the conformance to the protocol. (This is the struct actually following the rules set out by the protocol)
    var fullName: String  // get and set are made for you behind the scenes
    var favoriteColor: String
}

struct Starship: FullyNamed {
    var prefix: String?
    var name: String
    
    // Check if the starship has a prefix.  If so, add it and the name together to create the full name.  Otherwise, return the full name
    var fullName: String {
        get {
            if let prefix = prefix {
                return "\(prefix) \(name)"
                // return prefix + " " + name
            } else {
                return name
            }
        }
    }
}

protocol GeneratesRandomNumbers {
    func random() -> Int // not getting an error because the class that's using it must return the int
}

class ONeThroughTen: GeneratesRandomNumbers {
    func random() -> Int {
        return Int.random(in: 1...10)
    }
}

class ONeThroughOneHundread: GeneratesRandomNumbers {
    func random() -> Int {
        return Int.random(in: 1...100)
    }
}

let generator = ONeThroughOneHundread()
generator.random()

let me = Person(fullName: "kalvin zhao", favoriteColor: "blue")
let sam = Person(fullName: "Sam curtis", favoriteColor: "red")

// Extensions allow us to "Extend" the functionality ofa data type without needing to do back to the data type's declaration
extension Person: Equatable{
    
}


