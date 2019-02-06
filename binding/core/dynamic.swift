import Foundation

class Dynamic<T> {
    typealias BindType = ((T) -> Void)
    
    // MARK: - Properties
    private var binds: [BindType] = []
    
    /// Dynamic raw value
    var value: T {
        didSet {
            self.execBinds()
        }
    }
    
    // MARK: - Initialize
    
    /// Initializer
    ///
    /// - Parameter val: initial dynamic value
    init(_ val: T) {
        value = val
    }
    
    // MARK: - Public Methods
    
    /// Bind value for changes
    ///
    /// - Parameters:
    ///   - skip: Should skip initil closure call
    ///   - bind: closure to execute every time value changed
    func bind(skip: Bool = false, _ bind: @escaping BindType) {
        binds.append(bind)
        if skip { return }
        bind(value)
    }
    
    // MARK: - Private Methods
    private func execBinds() {
        self.binds.forEach { [unowned self] bind in
            bind(self.value)
        }
    }
}

class ConverterDynamic<T, R> : Dynamic<R> {
    typealias Get = (T) -> R
    typealias Set = (R) -> T

    private let dynamic : Dynamic<T>
    private var initalizing = false
    private var binding = false
    private var setConverter: Set? = nil
    private var getConverter: Get
    
    init(_ dynamic: Dynamic<T>, set setConverter: Set? = nil, get getConverter: @escaping Get) {
        initalizing = true

        self.dynamic = dynamic
        self.setConverter = setConverter
        self.getConverter = getConverter
        
        super.init(getConverter(dynamic.value))
        
        self.dynamic.bind { value in
            if !self.initalizing {
                self.binding = true
                self.value = getConverter(value)
                self.binding = false
            }
        }
        
        initalizing = false
    }
    
    override var value: R {
        get {
            return getConverter(self.dynamic.value)
        }
        set {
            if let inConverter = self.setConverter, !binding {
                dynamic.value = inConverter(newValue)
            }
            
            super.value = newValue
        }
    }
}
