import Foundation
import UIKit

class UITextFieldBinder : Binder {
    typealias TBindable = UITextField
    
    let bindable : TBindable
    private let textTwoWayBind : UIControlTwoWayBind<String>
    private let isEnabledOneWayBind = OneWayBind<Bool>()
    
    init(bindable: TBindable) {
        self.bindable = bindable
        
        self.textTwoWayBind = UIControlTwoWayBind<String>(bindable.text ?? "", control: self.bindable, for: UIControl.Event.editingChanged)
    }
    
    func text(_ dynamic: Dynamic<String>, withTwoWay: Bool = false) {
        textTwoWayBind.bind(dynamic, withTwoWay: withTwoWay) { value in
            self.bindable.text = value
        }
    }
    
    func isEnabled(_ dynamic: Dynamic<Bool>) {
        isEnabledOneWayBind.bind(dynamic) { value in
            self.bindable.isEnabled = value
        }
    }
}

extension UITextField: Bindable {
    typealias TBinder = UITextFieldBinder
    
    func bind() -> TBinder {
        return UITextFieldBinder(bindable: self)
    }
}

