import Foundation

class Counter {
    var value = 0
    
    func increment() {
        value += 1
    }
}

let counter = Counter()

let queue = DispatchQueue(label: "dataRaceSample", attributes: .concurrent)

let group = DispatchGroup()

for _ in 0..<10000 {
    queue.async(group: group) {
        counter.increment()
    }
}

group.wait()  // Waits for all asynchrnous executions to finish

print("Valor final: \(counter.value)") // Impredictible result. Oftenly below 10000.
