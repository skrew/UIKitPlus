import UIKit
#if !os(tvOS)
public typealias UStepper = Stepper
open class Stepper: UIStepper, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: Stepper { self }
    public lazy var properties = Properties<Stepper>()
    lazy var _properties = PropertiesInternal()
    
    @UIKitPlus.UState public var height: CGFloat = 0
    @UIKitPlus.UState public var width: CGFloat = 0
    @UIKitPlus.UState public var top: CGFloat = 0
    @UIKitPlus.UState public var leading: CGFloat = 0
    @UIKitPlus.UState public var left: CGFloat = 0
    @UIKitPlus.UState public var trailing: CGFloat = 0
    @UIKitPlus.UState public var right: CGFloat = 0
    @UIKitPlus.UState public var bottom: CGFloat = 0
    @UIKitPlus.UState public var centerX: CGFloat = 0
    @UIKitPlus.UState public var centerY: CGFloat = 0
    
    var __height: UIKitPlus.UState<CGFloat> { $height }
    var __width: UIKitPlus.UState<CGFloat> { $width }
    var __top: UIKitPlus.UState<CGFloat> { $top }
    var __leading: UIKitPlus.UState<CGFloat> { $leading }
    var __left: UIKitPlus.UState<CGFloat> { $left }
    var __trailing: UIKitPlus.UState<CGFloat> { $trailing }
    var __right: UIKitPlus.UState<CGFloat> { $right }
    var __bottom: UIKitPlus.UState<CGFloat> { $bottom }
    var __centerX: UIKitPlus.UState<CGFloat> { $centerX }
    var __centerY: UIKitPlus.UState<CGFloat> { $centerY }
    
    public init(_ value: Double) {
        super.init(frame: .zero)
        self.value = value
        setup()
    }
    
    public init(_ state: UIKitPlus.UState<Double>) {
        super.init(frame: .zero)
        valueBinding = state
        self.value = state.wrappedValue
        setup()
    }
    
    public init<V>(_ expressable: ExpressableState<V, Double>) {
        super.init(frame: .zero)
        valueBinding = expressable.unwrap()
        self.value = expressable.value()
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
    
    private var isContinuousBinding: UIKitPlus.UState<Bool>?
    private var autorepeatBinding: UIKitPlus.UState<Bool>?
    private var wrapsBinding: UIKitPlus.UState<Bool>?
    private var valueBinding: UIKitPlus.UState<Double>?
    private var minValueBinding: UIKitPlus.UState<Double>?
    private var maxValueBinding: UIKitPlus.UState<Double>?
    private var stepValueBinding: UIKitPlus.UState<Double>?
    
    public typealias ChangedClosure = (Double) -> Void
    private var _valueChanged: ChangedClosure?
    
    @objc
    private func valueChanged() {
        _valueChanged?(value)
        valueBinding?.wrappedValue = value
    }
    
    @discardableResult
    public func changed(_ callback: @escaping ChangedClosure) -> Self {
        _valueChanged = callback
        return self
    }
    
    // if YES, value change events are sent any time the value changes during interaction. default = YES
    @discardableResult
    public func isContinuous(_ value: Bool = true) -> Self {
        isContinuousBinding?.wrappedValue = value
        isContinuous = value
        return self
    }
    
    @discardableResult
    public func isContinuous(_ state: UIKitPlus.UState<Bool>) -> Self {
        isContinuousBinding = state
        isContinuous = state.wrappedValue
        return self
    }
    
    @discardableResult
    public func isContinuous<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        isContinuousBinding = expressable.unwrap()
        isContinuous = expressable.value()
        return self
    }
    
    // if YES, press & hold repeatedly alters value. default = YES
    @discardableResult
    public func autorepeat(_ value: Bool = true) -> Self {
        autorepeatBinding?.wrappedValue = value
        autorepeat = value
        return self
    }
    
    @discardableResult
    public func autorepeat(_ state: UIKitPlus.UState<Bool>) -> Self {
        autorepeatBinding = state
        autorepeat = state.wrappedValue
        return self
    }
    
    @discardableResult
    public func autorepeat<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        autorepeatBinding = expressable.unwrap()
        autorepeat = expressable.value()
        return self
    }
    
    // if YES, value wraps from min <-> max. default = NO
    @discardableResult
    public func wraps(_ value: Bool = true) -> Self {
        wrapsBinding?.wrappedValue = value
        wraps = value
        return self
    }
    
    @discardableResult
    public func wraps(_ state: UIKitPlus.UState<Bool>) -> Self {
        wrapsBinding = state
        wraps = state.wrappedValue
        return self
    }
    
    @discardableResult
    public func wraps<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        wrapsBinding = expressable.unwrap()
        wraps = expressable.value()
        return self
    }
    
    // default is 0. sends UIControlEventValueChanged. clamped to min/max
    @discardableResult
    public func value(_ value: Double) -> Self {
        valueBinding?.wrappedValue = value
        self.value = value
        return self
    }
    
    @discardableResult
    public func value(_ state: UIKitPlus.UState<Double>) -> Self {
        valueBinding = state
        value = state.wrappedValue
        return self
    }
    
    @discardableResult
    public func value<V>(_ expressable: ExpressableState<V, Double>) -> Self {
        valueBinding = expressable.unwrap()
        self.value = expressable.value()
        return self
    }
    
    // default 0. must be less than maximumValue
    @discardableResult
    public func minimumValue(_ value: Double) -> Self {
        minValueBinding?.wrappedValue = value
        minimumValue = value
        return self
    }
    
    @discardableResult
    public func minimumValue(_ state: UIKitPlus.UState<Double>) -> Self {
        minValueBinding = state
        minimumValue = state.wrappedValue
        return self
    }
    
    @discardableResult
    public func minimumValue<V>(_ expressable: ExpressableState<V, Double>) -> Self {
        minValueBinding = expressable.unwrap()
        minimumValue = expressable.value()
        return self
    }
    
    // default 100. must be greater than minimumValue
    @discardableResult
    public func maximumValue(_ value: Double) -> Self {
        maxValueBinding?.wrappedValue = value
        maximumValue = value
        return self
    }
    
    @discardableResult
    public func maximumValue(_ state: UIKitPlus.UState<Double>) -> Self {
        maxValueBinding = state
        maximumValue = state.wrappedValue
        return self
    }
    
    @discardableResult
    public func maximumValue<V>(_ expressable: ExpressableState<V, Double>) -> Self {
        maxValueBinding = expressable.unwrap()
        maximumValue = expressable.value()
        return self
    }
    
    // default 1. must be greater than 0
    @discardableResult
    public func stepValue(_ value: Double) -> Self {
        stepValueBinding?.wrappedValue = value
        stepValue = value
        return self
    }
    
    @discardableResult
    public func stepValue(_ state: UIKitPlus.UState<Double>) -> Self {
        stepValueBinding = state
        stepValue = state.wrappedValue
        return self
    }
    
    @discardableResult
    public func stepValue<V>(_ expressable: ExpressableState<V, Double>) -> Self {
        stepValueBinding = expressable.unwrap()
        stepValue = expressable.value()
        return self
    }
}
#endif
