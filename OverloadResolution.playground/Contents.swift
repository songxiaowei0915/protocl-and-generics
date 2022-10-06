import Foundation

func mod(_ m: Double, by n:Double) -> Double {
    print("Double ver.")
    return m.truncatingRemainder(dividingBy: n)
}

func mod(_ m: Float, by n: Float) -> Float {
    print("Float ver.")
    return m.truncatingRemainder(dividingBy: n)
}

func mod<T: SignedInteger>(_ m: T, by n: T) -> T {
    print("Generic ver.")
    return m % n
}

_ = mod(8, by: 2.5)
let eight: Float = 8
_ = mod(eight, by: 2.5)
_ = mod(8, by: 2)

let doubles = [2, 3, 4.5]
doubles.forEach { _ = mod ($0, by: 2)}


infix operator %%: MultiplicationPrecedence

func %%(_ m: Double, n:Double) -> Double {
    print("Double ver.")
    return m.truncatingRemainder(dividingBy: n)
}

func %%(_ m: Float, n: Float) -> Float {
    print("Float ver.")
    return m.truncatingRemainder(dividingBy: n)
}

func %%<T: SignedInteger>(_ m: T,  n: T) -> T {
    print("Generic ver.")
    return m % n
}

8 %% 2.5
Float(8) %% 2.5
let number:Int = 8 %% 2

func find<T: Collection> (
    value: T.Iterator.Element,
    in coll: T
) -> Bool where T.Iterator.Element: Equatable{
    print("Equatable find")
    
    var pos = coll.makeIterator()
    var tmp = pos.next()
    
    while let n = tmp {
        if n == value {
            return true
        }
        
        tmp = pos.next()
    }
    
    return false
}

func find<T: Collection> (
    value: T.Iterator.Element,
    in coll: T
) -> Bool where T.Iterator.Element: Hashable{
    print("Hashble find")
    
    return Set(coll).contains(value)
}

print(find(value: 10, in: [1, 2, 3]))
