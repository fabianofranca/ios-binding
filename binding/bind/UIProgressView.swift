import Foundation
import UIKit

struct UIProgressViewBinder : Binder {
    typealias TBindable = UIProgressView
    
    let bindable: TBindable
    
    private let progressOneWayBind = OneWayBind<Float>()
    
    func progress(_ dynamic: Dynamic<Float>) {
        progressOneWayBind.bind(dynamic) { value in
            self.bindable.progress = value
        }
    }
}

extension UIProgressView: Bindable {
    typealias TBinder = UIProgressViewBinder
    
    func bind() -> TBinder {
        return UIProgressViewBinder(bindable: self)
    }
}
