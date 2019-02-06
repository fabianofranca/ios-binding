import Foundation
import UIKit

class UISwitchBinder : Binder {
    typealias TBindable = UISwitch
    
    let bindable : TBindable
    private let isOnTwoWayBind : UIControlTwoWayBind<Bool>
    
    init(bindable: TBindable) {
        self.bindable = bindable
        
        self.isOnTwoWayBind = UIControlTwoWayBind<Bool>(bindable.isOn, control: self.bindable, for: UIControl.Event.valueChanged)
    }
    
    func isOn(_ dynamic: Dynamic<Bool>, withTwoWay: Bool = false) {
        isOnTwoWayBind.bind(dynamic, withTwoWay: withTwoWay) { value in
            self.bindable.isOn = value
        }
    }
}

extension UISwitch: Bindable {
    typealias TBinder = UISwitchBinder
    
    func bind() -> TBinder {
        return UISwitchBinder(bindable: self)
    }
}

