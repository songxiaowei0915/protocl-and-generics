import Foundation

protocol Drivable {
    func selfCheck() -> Bool
    func startEngine()
    func shiftUp()
    func go()
}

class Car {
    func selfCheck() -> Bool {
        return true
    }
    
    func startEngine() {}
    func shiftUp() {}
    func go() {}
    
    func lightUp(){}
    func horn() {}
    func lock() {}
}

func drvie<T: Drivable>(_ car: T) {
    if !car.selfCheck() {
        car.selfCheck()
        car.shiftUp()
        car.go()
    }
}

class Roadster: Drivable {
    func selfCheck() -> Bool {
        return true
    }
    
    func startEngine() {
    }
    
    func shiftUp() {
    }
    
    func go() {
    }
}

class SUV: Drivable {
    func selfCheck() -> Bool {
        return true
    }
    
    func startEngine() {
    }
    
    func shiftUp() {
    }
    
    func go() {
    }
}

drvie(Roadster())
drvie(SUV())


