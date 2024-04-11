struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    let amount: Int
    let currency: String
    
    
    private func toUSD() -> Int {
        switch currency {
        case "GBP":
            return amount*2
        case "EUR":
            return Int((Double(amount)/1.5).rounded())
        case "CAN":
            return Int((Double(amount)/1.25).rounded())
        default :
            return amount
        }
    }
    private func fromUSD(fromAmnt : Int, toCncy: String) -> Int {
        switch toCncy {
        case "GBP":
            return Int((Double(fromAmnt)/2).rounded())
        case "EUR":
            return Int((Double(fromAmnt)*1.5).rounded())
        case "CAN":
            return Int((Double(fromAmnt)*1.25).rounded())
        default:
            return fromAmnt
        }
    }
    
    public func convert(_ toCncy: String) -> Money {
        let usdAmnt = self.toUSD()
        let toAmnt = fromUSD(fromAmnt: usdAmnt, toCncy: toCncy)
        return Money(amount: toAmnt, currency: toCncy)
    }
    
    public func add(_ subject: Money) -> Money {
        let converted = self.convert(subject.currency)
        let totalAmnt = converted.amount + subject.amount
        return Money(amount: totalAmnt, currency: subject.currency)
    }
    public func subtract(_ subject: Money) -> Money {
        let converted = self.convert(subject.currency)
        let totalAmnt = converted.amount - subject.amount
        return Money(amount: totalAmnt, currency: subject.currency)
    }
}

////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    var title: String
    var type: JobType
    
    public init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    
    public func calculateIncome(_ multiplier : Int = 2000) -> Int {
        switch type {
        case .Hourly(let wage):
            return Int(wage * Double(multiplier))
        case .Salary(let salary):
            return Int(salary)
        }
    }
    public func raise(byAmount amount: Double) {
        switch type {
        case .Salary(let salary):
            self.type = .Salary(salary + UInt(Int(amount)))
        case .Hourly(let wage):
            self.type = .Hourly(wage + amount)
        }
    }
    public func raise(byPercent perc: Double) {
        switch type {
        case .Salary(let salary):
            self.type = .Salary(UInt(Double(salary) + Double(salary) * perc))
        case .Hourly(let wage) :
            self.type = .Hourly(wage + wage * Double(perc))
        }
    }
}

////////////////////////////////////
// Person
//
public class Person {
    public var firstName: String
    public var lastName: String
    public var age: Int
    public var job: Job?
    public var spouse: Person?
    
    public init(firstName first: String, lastName last: String, age: Int) {
        self.firstName = first
        self.lastName = last
        self.age = age
        self.job = nil
        self.spouse = nil
    }
    public func toString() -> String {
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job?.title ?? "nil") spouse:\(self.spouse?.firstName ?? "nil")]"
    }
}

////////////////////////////////////
// Family
//
public class Family {
    var members: [Person]
    
    public init(spouse1 one: Person, spouse2 two: Person) {
        one.spouse = two
        two.spouse = one
        self.members = [one, two]
    }
    public func haveChild(_ child: Person) -> Bool {
        var canHave = false
        for person in members {
            if person.age >= 21 {
                canHave = true
            }
        }
        switch canHave {
        case true:
            members.append(child)
        case false:
            print("None of the members is adult, they cannot have child")
        }
        return canHave
    }
    public func householdIncome() -> Int {
        var total = 0
        for person in members {
            if person.job != nil {
                total += person.job!.calculateIncome()
            }
        }
        return total
    }
}
