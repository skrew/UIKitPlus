import UIKit

extension DeclarativeProtocol {
    @discardableResult
    private func _aspectRatio(multiplier: CGFloat, priority: UILayoutPriority) -> Self {
        let pc = PreConstraint(value: .init(wrappedValue: 0),
                                        relation: .equal,
                                        multiplier: multiplier,
                                        priority: priority,
                                        attribute1: .width,
                                        attribute2: .height,
                                        toSafe: false,
                                        fromView: declarativeView,
                                        destinationView: declarativeView)
        if let _ = declarativeView.superview {
            declarativeView.activateSolo(pc)
        } else {
            _declarativeView._properties.notAppliedPreConstraintsSolo.append(pc)
        }
        return self
    }
    
    @discardableResult
    public func aspectRatio(_ multiplier: CGFloat = 1, priority: UILayoutPriority = .defaultHigh) -> Self {
        _aspectRatio(multiplier: multiplier, priority: priority)
    }
    
    @discardableResult
    private func _dimension(_ value: UState<CGFloat>,
                                        attribute: NSLayoutConstraint.Attribute,
                                        relation: NSLayoutConstraint.Relation,
                                        multiplier: CGFloat,
                                        priority: UILayoutPriority) -> Self {
        let pc = PreConstraint(value: value,
                                        relation: relation,
                                        multiplier: multiplier,
                                        priority: priority,
                                        attribute1: attribute,
                                        attribute2: nil,
                                        toSafe: false,
                                        fromView: declarativeView,
                                        destinationView: nil)
        
        if let _ = declarativeView.superview {
            declarativeView.activateSolo(pc)
        } else {
            _declarativeView._properties.notAppliedPreConstraintsSolo.append(pc)
        }
        return self
    }
    
    @discardableResult
    private func _dimension<V>(_ expressable: ExpressableState<V, CGFloat>,
                                        attribute: NSLayoutConstraint.Attribute,
                                        relation: NSLayoutConstraint.Relation,
                                        multiplier: CGFloat,
                                        priority: UILayoutPriority) -> Self {
        _dimension(expressable.unwrap(), attribute: attribute, relation: relation, multiplier: multiplier, priority: priority)
    }
    
    @discardableResult
    public func width(_ value: UState<CGFloat>,
                      relation: NSLayoutConstraint.Relation = .equal,
                      multiplier: CGFloat = 1,
                      priority: UILayoutPriority = .defaultHigh) -> Self {
        _dimension(value, attribute: .width, relation: relation, multiplier: multiplier, priority: priority)
    }
    
    @discardableResult
    public func width<V>(_ value: ExpressableState<V, CGFloat>,
                         relation: NSLayoutConstraint.Relation = .equal,
                         multiplier: CGFloat = 1,
                         priority: UILayoutPriority = .defaultHigh) -> Self {
        _dimension(value, attribute: .width, relation: relation, multiplier: multiplier, priority: priority)
    }
    
    @discardableResult
    public func width(_ value: ConstraintValue) -> Self {
        width(UState<CGFloat>(wrappedValue: value.constraintValue.value),
              relation: value.constraintValue.relation,
              multiplier: value.constraintValue.multiplier,
              priority: value.constraintValue.priority)
    }
    
    @discardableResult
    public func height(_ value: UState<CGFloat>,
                        relation: NSLayoutConstraint.Relation = .equal,
                        multiplier: CGFloat = 1,
                        priority: UILayoutPriority = .defaultHigh) -> Self {
        _dimension(value, attribute: .height, relation: relation, multiplier: multiplier, priority: priority)
    }
    
    @discardableResult
    public func height<V>(_ value: ExpressableState<V, CGFloat>,
                            relation: NSLayoutConstraint.Relation = .equal,
                            multiplier: CGFloat = 1,
                            priority: UILayoutPriority = .defaultHigh) -> Self {
        _dimension(value, attribute: .height, relation: relation, multiplier: multiplier, priority: priority)
    }
    
    @discardableResult
    public func height(_ value: ConstraintValue) -> Self {
        height(UState<CGFloat>(wrappedValue: value.constraintValue.value),
               relation: value.constraintValue.relation,
               multiplier: value.constraintValue.multiplier,
               priority: value.constraintValue.priority)
    }
    
    @discardableResult
    public func size(_ state: UState<CGFloat>,
                        relation: NSLayoutConstraint.Relation = .equal,
                        multiplier: CGFloat = 1,
                        priority: UILayoutPriority = .defaultHigh) -> Self {
        width(state, relation: relation, multiplier: multiplier, priority: priority).height(state, relation: relation, multiplier: multiplier, priority: priority)
    }
    
    @discardableResult
    public func size<V>(_ state: ExpressableState<V, CGFloat>,
                        relation: NSLayoutConstraint.Relation = .equal,
                        multiplier: CGFloat = 1,
                        priority: UILayoutPriority = .defaultHigh) -> Self {
        width(state, relation: relation, multiplier: multiplier, priority: priority).height(state, relation: relation, multiplier: multiplier, priority: priority)
    }
    
    @discardableResult
    public func size(_ value: ConstraintValue) -> Self {
        width(value).height(value)
    }
    
    @discardableResult
    public func size(_ w: UState<CGFloat>, _ h: UState<CGFloat>,
                        relation: NSLayoutConstraint.Relation = .equal,
                        multiplier: CGFloat = 1,
                        priority: UILayoutPriority = .defaultHigh) -> Self {
        width(w, relation: relation, multiplier: multiplier, priority: priority).height(h, relation: relation, multiplier: multiplier, priority: priority)
    }
    
    @discardableResult
    public func size<V>(_ w: ExpressableState<V, CGFloat>, _ h: UState<CGFloat>,
                            relation: NSLayoutConstraint.Relation = .equal,
                            multiplier: CGFloat = 1,
                            priority: UILayoutPriority = .defaultHigh) -> Self {
        width(w, relation: relation, multiplier: multiplier, priority: priority).height(h, relation: relation, multiplier: multiplier, priority: priority)
    }
    
    @discardableResult
    public func size<V>(_ w: UState<CGFloat>, _ h: ExpressableState<V, CGFloat>,
                            relation: NSLayoutConstraint.Relation = .equal,
                            multiplier: CGFloat = 1,
                            priority: UILayoutPriority = .defaultHigh) -> Self {
        width(w, relation: relation, multiplier: multiplier, priority: priority).height(h, relation: relation, multiplier: multiplier, priority: priority)
    }
    
    @discardableResult
    public func size<A, B>(_ w: ExpressableState<A, CGFloat>, _ h: ExpressableState<B, CGFloat>,
                            relation: NSLayoutConstraint.Relation = .equal,
                            multiplier: CGFloat = 1,
                            priority: UILayoutPriority = .defaultHigh) -> Self {
        width(w, relation: relation, multiplier: multiplier, priority: priority).height(h, relation: relation, multiplier: multiplier, priority: priority)
    }
    
    @discardableResult
    public func size(_ w: ConstraintValue, _ h: ConstraintValue) -> Self {
        width(w).height(h)
    }
    
    // MARK: - Activation
    
    func activateSolo(_ pc: PreConstraint) {
        guard let superview = declarativeView.superview else { return }
        guard let _self = self as? DeclarativeProtocolInternal else { return }
        // Deactivate duplicate constraint and remove it from array
        _self._properties.notAppliedPreConstraintsSolo.removeAll { $0 != pc && $0.attribute1 == pc.attribute1 && $0.relation == pc.relation }
        if let index = _self._properties.appliedPreConstraintsSolo.firstIndex(where: { $0.attribute1 == pc.attribute1 && $0.relation == pc.relation }) {
            _self._properties.appliedPreConstraintsSolo[index].constraint?.isActive = false
            _self._properties.appliedPreConstraintsSolo[index].constraint?.shouldBeArchived = true
            _self._properties.appliedPreConstraintsSolo.remove(at: index)
        }
        // Move pre constraint from not applied to applied
        _self._properties.notAppliedPreConstraintsSolo.removeAll(where: { $0 === pc })
        _self._properties.appliedPreConstraintsSolo.append(pc)
        // Create constraint
        let constraint = NSLayoutConstraint(item: self,
                                                              attribute: pc.attribute1,
                                                              relatedBy: pc.relation,
                                                              toItem: pc.destinationView,
                                                              attribute: pc.attribute2 ?? .notAnAttribute,
                                                              multiplier: pc.multiplier,
                                                              constant: pc.value.wrappedValue)
        // Store constraint into pre constraint
        pc.constraint = constraint
        // Activate constraint
        constraint.isActive = true
        // Link internal state with external
        linkStates(pc.attribute1, _self, pc.value)
        // Redraw itself
        superview.layoutIfNeeded()
    }
}
