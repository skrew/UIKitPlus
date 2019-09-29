import UIKit

/// aka `UILabel`
@available(*, deprecated, renamed: "Text")
public typealias Label = Text

/// aka `UILabel`
open class Text: UILabel, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: Label { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    public init (_ text: String = "") {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.text = text
    }
    
    public init (_ text: State<String>) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.text = text.wrappedValue
        text.listen { self.text = $0 }
    }
    
    public init (_ attributedStrings: AttributedString...) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        let attrStr = NSMutableAttributedString(string: "")
        attributedStrings.forEach {
            attrStr.append($0.attributedString)
        }
        attributedText = attrStr
    }
    
    var stateString: StateStringBuilder.Handler?
    
    public init (@StateStringBuilder stateString: @escaping StateStringBuilder.Handler) {
        self.stateString = stateString
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.text = stateString()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
    
    /// Refreshes using `RefreshHandler`
    public func refresh() {
        if let stateString = stateString {
            text = stateString()
        }
    }
    
    @discardableResult
    public func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    public func text(_ attributedStrings: AttributedString...) -> Self {
        let attrStr = NSMutableAttributedString(string: "")
        attributedStrings.forEach {
            attrStr.append($0.attributedString)
        }
        attributedText = attrStr
        return self
    }
    
    @discardableResult
    public func color(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    @discardableResult
    public func color(_ number: Int) -> Self {
        textColor = number.color
        return self
    }
    
    @discardableResult
    public func font(v: UIFont?) -> Self {
        self.font = v
        return self
    }
    
    @discardableResult
    public func minimumScaleFactor(_ value: CGFloat) -> Self {
        self.minimumScaleFactor = value
        return self
    }
    
    @discardableResult
    public func lineBreakMode(_ mode: NSLineBreakMode) -> Self {
        self.lineBreakMode = mode
        return self
    }
    
    @discardableResult
    public func adjustsFontSizeToFitWidth(_ value: Bool = true) -> Self {
        self.adjustsFontSizeToFitWidth = value
        return self
    }
    
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat) -> Self {
        return font(v: UIFont(name: identifier.fontName, size: size))
    }
    
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func lines(_ number: Int) -> Self {
        numberOfLines = number
        return self
    }
    
    @discardableResult
    public func multiline() -> Self {
        numberOfLines = 0
        return self
    }
    
    // MARK: Reaction on @State
    
    @discardableResult
    public func react<A>(to a: State<A>) -> Self {
        a.listen { _ in self.refresh() }
        return self
    }
    
    @discardableResult
    public func react<A, B>(to a: State<A>, _ b: State<B>) -> Self {
        a.listen { _ in self.refresh() }
        b.listen { _ in self.refresh() }
        return self
    }
    
    @discardableResult
    public func react<A, B, C>(to a: State<A>, _ b: State<B>, _ c: State<C>) -> Self {
        a.listen { _ in self.refresh() }
        b.listen { _ in self.refresh() }
        c.listen { _ in self.refresh() }
        return self
    }
    
    @discardableResult
    public func react<A, B, C, D>(to a: State<A>, _ b: State<B>, _ c: State<C>, _ d: State<D>) -> Self {
        a.listen { _ in self.refresh() }
        b.listen { _ in self.refresh() }
        c.listen { _ in self.refresh() }
        d.listen { _ in self.refresh() }
        return self
    }
    
    @discardableResult
    public func react<A, B, C, D, E>(to a: State<A>, _ b: State<B>, _ c: State<C>, _ d: State<D>, _ e: State<E>) -> Self {
        a.listen { _ in self.refresh() }
        b.listen { _ in self.refresh() }
        c.listen { _ in self.refresh() }
        d.listen { _ in self.refresh() }
        e.listen { _ in self.refresh() }
        return self
    }
}