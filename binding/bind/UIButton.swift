import Foundation
import UIKit

struct UIButtonBinder : Binder {
    typealias TBindable = UIButton
    
    let bindable: TBindable
    
    private let isEnabledOneWayBind = OneWayBind<Bool>()
    
    func isEnabled(_ dynamic: Dynamic<Bool>) {
        isEnabledOneWayBind.bind(dynamic) { value in
            self.bindable.isEnabled = value
        }
    }
}

extension UIButton: Bindable {
    typealias TBinder = UIButtonBinder
    
    func bind() -> TBinder {
        return UIButtonBinder(bindable: self)
    }
}
