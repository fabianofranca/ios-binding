import Foundation
import UIKit

class UISliderBinder : Binder {
    typealias TBindable = UISlider
    
    let bindable : TBindable
    private let valueTwoWayBind : UIControlTwoWayBind<Float>
    
    init(bindable: TBindable) {
        self.bindable = bindable
        
        self.valueTwoWayBind = UIControlTwoWayBind<Float>(bindable.value, control: self.bindable, for: UIControl.Event.valueChanged)
    }
    
    func value(_ dynamic: Dynamic<Float>, withTwoWay: Bool = false) {
        valueTwoWayBind.bind(dynamic, withTwoWay: withTwoWay) { value in
            self.bindable.value = value
        }
    }
}

extension UISlider: Bindable {
    typealias TBinder = UISliderBinder
    
    func bind() -> TBinder {
        return UISliderBinder(bindable: self)
    }
}

