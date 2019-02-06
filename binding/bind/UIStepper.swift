import Foundation
import UIKit

class UIStepperBinder : Binder {
    typealias TBindable = UIStepper
    
    let bindable : TBindable
    private let valueTwoWayBind : UIControlTwoWayBind<Double>
    
    init(bindable: TBindable) {
        self.bindable = bindable
        
        self.valueTwoWayBind = UIControlTwoWayBind<Double>(bindable.value, control: self.bindable, for: UIControl.Event.valueChanged)
    }
    
    func value(_ dynamic: Dynamic<Double>, withTwoWay: Bool = false) {
        valueTwoWayBind.bind(dynamic, withTwoWay: withTwoWay) { value in
            self.bindable.value = value
        }
    }
}

extension UIStepper: Bindable {
    typealias TBinder = UIStepperBinder
    
    func bind() -> TBinder {
        return UIStepperBinder(bindable: self)
    }
}

