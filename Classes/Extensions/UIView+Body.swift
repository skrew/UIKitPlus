import UIKit

extension UIView {
    @discardableResult
    open func body(@ViewBuilder block: ViewBuilder.SingleView) -> Self {
        addItem(block())
        return self
    }
    
    func addItem(_ item: ViewBuilderItemable, at index: Int? = nil) {
        addItem(item.viewBuilderItem, at: index)
    }
    
    func addItem(_ item: ViewBuilderItem, at index: Int? = nil) {
        switch item {
        case .single(let view):
            add(views: [view], at: index)
        case .multiple(let views):
            add(views: views, at: index)
        case .forEach(let fr):
            let subview = View().edgesToSuperview()
            fr.allItems().forEach {
                subview.addItem($0)
            }
            add(views: [subview], at: index)
            fr.subscribeToChanges({}, { deletions, insertions, _ in
                subview.subviews.removeFromSuperview(at: deletions)
                insertions.forEach {
                    subview.addItem(fr.items(at: $0), at: $0)
                }
            }) {}
            break
        case .nested(let items):
            items.forEach { addItem($0, at: index) }
            break
        case .none:
            break
        }
    }
    
    func add(views: [UIView], at index: Int?) {
        guard let index = index else {
            addSubview(views)
            return
        }
        let nextViews = subviews.dropFirst(index)
        nextViews.forEach { $0.removeFromSuperview() }
        addSubview(views)
        nextViews.forEach { self.addSubview($0) }
    }
}
