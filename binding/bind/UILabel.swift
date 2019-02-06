import Foundation
import UIKit

struct UILabelBinder : Binder {
    typealias TBindable = UILabel
    
    let bindable: TBindable
    
    private let textOneWayBind = OneWayBind<String>()
    
    func text(_ dynamic: Dynamic<String>) {
        textOneWayBind.bind(dynamic) { value in
            self.bindable.text = value
        }
    }
}

extension UILabel: Bindable {
    typealias TBinder = UILabelBinder
    
    func bind() -> TBinder {
        return UILabelBinder(bindable: self)
    }
}
