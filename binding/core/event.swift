import Foundation

class Event<T> {
    typealias Subscriber = (T?) -> Void
    
    private var subscribers: [Subscriber] = []
    
    private var completion: ((T) -> Void)?
    
    init() {}
    
    func trigger(_ data: T? = nil) {
        subscribers.forEach { subscriber in
            subscriber(data)
        }
    }
    
    func subscribe(_ subscriber: @escaping Subscriber) {
        subscribers.append(subscriber)
    }
}

class SimpleEvent : Event<Any> {
    override init() {}
    
    func subscribe(_ subscriber: @escaping () -> Void) {
        super.subscribe { _ in
            subscriber()
        }
    }
}
