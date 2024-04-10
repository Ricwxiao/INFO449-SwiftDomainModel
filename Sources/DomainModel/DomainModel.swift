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
    
    func convert(_ toCncy: String) -> Money {
        let usdAmnt = self.toUSD()
        let toAmnt = fromUSD(fromAmnt: usdAmnt, toCncy: toCncy)
        return Money(amount: toAmnt, currency: toCncy)
    }
    
    func add(_ subject : Money) -> Money {
        let converted = self.convert(subject.currency)
        let totalAmnt = converted.amount + subject.amount
        return Money(amount: totalAmnt, currency: subject.currency)
    }
    func subtract(_ subject : Money) -> Money {
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
}

////////////////////////////////////
// Person
//
public class Person {
}

////////////////////////////////////
// Family
//
public class Family {
}
