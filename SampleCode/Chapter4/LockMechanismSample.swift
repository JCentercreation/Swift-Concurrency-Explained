import Foundation

class LockedCounter {
    private var value = 0
    private let lock = NSLock()
    
    func increment() {
        lock.lock() // mutex lock
        defer { lock.unlock() } // unlocks when exits scope
        value += 1
    }
    
    func getValue() -> Int {
        lock.lock()
        defer { lock.unlock() }
        return value
    }
}

let counter = LockedCounter()

let queue = DispatchQueue(label: "lockMechanismSample", attributes: .concurrent)

let group = DispatchGroup()

for _ in 0..<10000 {
    queue.async(group: group) {
        counter.increment()
    }
}

group.wait() // Waits for all asynchronous executions to finish

print("Final value: \(counter.getValue())")  // Predictable result. Always 10000.

