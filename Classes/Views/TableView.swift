import UIKit

public typealias UTableView = TableView
open class TableView: UITableView, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: TableView { self }
    public lazy var properties = Properties<TableView>()
    lazy var _properties = PropertiesInternal()
    
    @UState public var height: CGFloat = 0
    @UState public var width: CGFloat = 0
    @UState public var top: CGFloat = 0
    @UState public var leading: CGFloat = 0
    @UState public var left: CGFloat = 0
    @UState public var trailing: CGFloat = 0
    @UState public var right: CGFloat = 0
    @UState public var bottom: CGFloat = 0
    @UState public var centerX: CGFloat = 0
    @UState public var centerY: CGFloat = 0
    
    var __height: UState<CGFloat> { _height }
    var __width: UState<CGFloat> { _width }
    var __top: UState<CGFloat> { _top }
    var __leading: UState<CGFloat> { _leading }
    var __left: UState<CGFloat> { _left }
    var __trailing: UState<CGFloat> { _trailing }
    var __right: UState<CGFloat> { _right }
    var __bottom: UState<CGFloat> { _bottom }
    var __centerX: UState<CGFloat> { _centerX }
    var __centerY: UState<CGFloat> { _centerY }
    
    var scrollPosition: UState<CGPoint>?
    
    public init (_ style: UITableView.Style = .plain) {
        super.init(frame: .zero, style: style)
        buildView()
    }
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        buildView()
    }
    
    func buildView() {
        translatesAutoresizingMaskIntoConstraints = false
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
    
    // MARK: Keyboard Dismiss Mode
    
    @discardableResult
    public func keyboardDismissMode(_ mode: UIScrollView.KeyboardDismissMode) -> Self {
        keyboardDismissMode = mode
        return self
    }
    
    // MARK: - Refresh Control
    #if !os(tvOS)
    @discardableResult
    public func refreshControl(_ refreshControl: UIRefreshControl) -> Self {
        if #available(iOS 10.0, *) {
            self.refreshControl = refreshControl
        } else {
            addSubview(refreshControl)
        }
        return self
    }
    #endif
    // MARK: Indicators
    
    @discardableResult
    public func hideIndicator(_ indicators: NSLayoutConstraint.Axis...) -> Self {
        if indicators.contains(.horizontal) {
            showsHorizontalScrollIndicator = false
        }
        if indicators.contains(.vertical) {
            showsVerticalScrollIndicator = false
        }
        return self
    }
    
    // MARK: Indicators
    
    @discardableResult
    public func hideAllIndicators() -> Self {
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        return self
    }
    
    // MARK: Content Inset
    
    @discardableResult
    public func contentInset(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        contentInset = .init(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    public func contentInset(x: CGFloat) -> Self {
        contentInset(top: 0, left: x, right: x, bottom: 0)
    }
    
    @discardableResult
    public func contentInset(y: CGFloat) -> Self {
        contentInset(top: y, left: 0, right: 0, bottom: y)
    }
    
    @discardableResult
    public func contentInset( _ value: CGFloat) -> Self {
        contentInset(top: value, left: value, right: value, bottom: value)
    }
    
    @discardableResult
    public func scrollIndicatorInsets(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        scrollIndicatorInsets = .init(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    public func scrollIndicatorInsets(x: CGFloat) -> Self {
        scrollIndicatorInsets(top: 0, left: x, right: x, bottom: 0)
    }
    
    @discardableResult
    public func scrollIndicatorInsets(y: CGFloat) -> Self {
        scrollIndicatorInsets(top: y, left: 0, right: 0, bottom: y)
    }
    
    @discardableResult
    public func scrollIndicatorInsets( _ value: CGFloat) -> Self {
        scrollIndicatorInsets(top: value, left: value, right: value, bottom: value)
    }
    
    @discardableResult
    public func contentOffset(_ value: CGFloat) -> Self {
        contentOffset = .init(x: 0, y: value)
        return self
    }
    
    @discardableResult
    public func automaticDimension(_ estimatedRowHeight: CGFloat = 44) -> Self {
        rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = estimatedRowHeight
        return self
    }
    
    @discardableResult
    public func delegate(_ value: UITableViewDelegate) -> Self {
        delegate = value
        return self
    }
    
    @discardableResult
    public func dataSource(_ value: UITableViewDataSource) -> Self {
        dataSource = value
        return self
    }
    #if !os(tvOS)
    @discardableResult
    public func separatorColor(_ value: UIColor) -> Self {
        separatorColor = value
        return self
    }
    
    @discardableResult
    public func separatorStyle(_ value: UITableViewCell.SeparatorStyle) -> Self {
        separatorStyle = value
        return self
    }
    #endif
    @discardableResult
    public func separatorInset(_ value: UIEdgeInsets) -> Self {
        separatorInset = value
        return self
    }
    
    @discardableResult
    public func separatorInset(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        separatorInset = .init(top: top, left: left, bottom: bottom, right: right)
        return self
    }
}

extension TableView: UIScrollViewDelegate {
    @discardableResult
    public func contentOffset(_ position: CGPoint, animated: Bool = true) -> Self {
        setContentOffset(position, animated: animated)
        return self
    }
    
    @discardableResult
    public func scrollPosition(_ binding: UIKitPlus.UState<CGPoint>) -> Self {
        scrollPosition = binding
        return self
    }
    
    @discardableResult
    public func scrollPosition<V>(_ expressable: ExpressableState<V, CGPoint>) -> Self {
        scrollPosition = expressable.unwrap()
        return self
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollPosition?.wrappedValue = scrollView.contentOffset
    }
}
