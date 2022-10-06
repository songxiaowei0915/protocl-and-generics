import Foundation

protocol Drawable {
    func draw()
}

struct Point: Drawable {
    var x: Int
    var y: Int
    
    func draw() {
        print("A point at: (x: \(x), y: \(y))")
    }
}

struct Line: Drawable {
    var x1: Int, y1: Int
    var x2: Int, y2: Int
    
    func draw() {
        print("A line from: (x: \(x1), y: \(y1)) " +
        "to (x: \(x2), y: \(y2))")
    }
}

func drawShape(_ shape: Drawable) {
    shape.draw()
}

let line = Line(x1: 2, y1: 2, x2: 6, y2: 6)
drawShape(line)
