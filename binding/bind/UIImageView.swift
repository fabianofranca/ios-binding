import Foundation
import UIKit

struct UIImageViewBinder : Binder {
    typealias TBindable = UIImageView
    
    let bindable: TBindable
    
    private let imageOneWayBind = OneWayBind<UIImage>()
    private let tintColorOneWayBind = OneWayBind<UIColor>()
    
    func image(_ dynamic: Dynamic<UIImage>) {
        imageOneWayBind.bind(dynamic) { value in
            self.bindable.image = value
        }
    }

    func tintColor(_ dynamic: Dynamic<UIColor>) {
        tintColorOneWayBind.bind(dynamic) { value in
            self.bindable.tintColor = value
        }
    }
}

extension UIImageView: Bindable {
    typealias TBinder = UIImageViewBinder
    
    func bind() -> TBinder {
        return UIImageViewBinder(bindable: self)
    }
}
