import UIKit

public protocol ListableBuilderItem {
    var listableBuilderItems: [Listable] { get }
}
struct EmptyListableBuilderItem: ListableBuilderItem {
    var listableBuilderItems: [Listable] { [] }
}
extension UIView: Listable {
    public var count: Int { 1 }
    public func item(at index: Int) -> VStack { VStack { View(inlineView: self) } }
}
extension UIView: ListableBuilderItem {
    public var listableBuilderItems: [Listable] {
        return [self]
    }
}
extension Array: ListableBuilderItem where Element: Listable {
    public var listableBuilderItems: [Listable] {
        return self
    }
}
extension Optional: ListableBuilderItem where Wrapped: Listable {
    public var listableBuilderItems: [Listable] {
        switch self {
        case .none: return []
        case .some(let value): return [value]
        }
    }
}