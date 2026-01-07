import Foundation

extension Thread {
    public nonisolated static var currentThread: Thread {
        return Thread.current
    }
}

struct ThreadHoppingSample {
    private func taskOne() async throws {
        print("Task 1 starts on thread: \(Thread.currentThread)")
        try await Task.sleep(for: .seconds(2))
        print("Task 1 resumes on thread: \(Thread.currentThread)")
    }

    private func taskTwo() async throws {
        print("Task 2 starts on thread: \(Thread.currentThread)")
        try await Task.sleep(for: .seconds(2))
        print("Task 2 resumes on thread: \(Thread.currentThread)")
    }

    func launchTasks() {
        Task {
            try await taskOne()
        }
        Task {
            try await taskTwo()
        }
    }
}

let threadHoppingSample = ThreadHoppingSample()

threadHoppingSample.launchTasks()
