import Foundation
import UIKit

protocol Binder {
    associatedtype TBindable : Bindable
    
    var bindable: TBindable { get }
}

protocol Bindable {
    associatedtype TBinder: Binder
    
    func bind() -> TBinder
}

class OneWayBind<TValue> {
    
    var bind: ((TValue) -> Void)?
    
    func bind(_ dynamic: Dynamic<TValue>, bind: @escaping (TValue) -> Void) {
        
        self.bind = bind
        
        dynamic.bind(binding)
    }
    
    func binding(_ value: TValue) {
        bind?(value)
    }
}


class TwoWayBind<TValue> : OneWayBind<TValue> {
    
    var withTwoWay = false
    var changing = false
    
    private let value : () -> TValue
    private weak var dynamic : Dynamic<TValue>? = nil
    
    init(_ value: @autoclosure @escaping () -> TValue) {
        self.value = value
    }
    
    override func binding(_ value: TValue) {
        if !changing {
            super.binding(value)
        }
    }
    
    func bind(_ dynamic: Dynamic<TValue>, withTwoWay: Bool = false, bind: @escaping (TValue) -> Void) {
        self.dynamic = dynamic
        
        super.bind(dynamic, bind: bind)
        
        self.withTwoWay = withTwoWay
    }
    
    func change() {
        if withTwoWay {
            changing = true
            
            dynamic?.value = value()
            
            changing = false
        }
    }
}

class UIControlTwoWayBind<TValue> : TwoWayBind<TValue> {
    
    init(_ value: @autoclosure @escaping () -> TValue, control: UIControl, for controlEvents: UIControl.Event) {
        super.init(value)
        
        control.addTarget(self, action: #selector(selector), for: controlEvents)
    }
    
    @objc private func selector() {
        change()
    }
}
