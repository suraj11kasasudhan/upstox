

import Foundation
import UIKit

public final class ObjectAssociation<T: AnyObject> {
    
    private let policy: objc_AssociationPolicy
    
    /// - Parameter policy: An association policy that will be used when linking objects.
    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        
        self.policy = policy
    }
    
    /// Accesses associated object.
    /// - Parameter index: An object whose associated object is to be accessed.
    public subscript(index: AnyObject) -> T? {
        
        get { return objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as! T? }
        set { objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, policy) }
    }
}

public extension UIView {
    
    private static let topConstraintAssociation = ObjectAssociation<NSLayoutConstraint>()
    
    private static let bottomConstraintAssociation = ObjectAssociation<NSLayoutConstraint>()
    
    private static let leadingConstraintAssociation = ObjectAssociation<NSLayoutConstraint>()
    
    private static let trailingConstraintAssociation = ObjectAssociation<NSLayoutConstraint>()
    
    private static let centerXConstraintAssociation = ObjectAssociation<NSLayoutConstraint>()
    
    private static let centerYConstraintAssociation = ObjectAssociation<NSLayoutConstraint>()
    
    private static let widthConstraintAssociation = ObjectAssociation<NSLayoutConstraint>()
    
    private static let heightConstraintAssociation = ObjectAssociation<NSLayoutConstraint>()
    
    var topConstraint: NSLayoutConstraint {
        get { return UIView.topConstraintAssociation[self] ?? NSLayoutConstraint() }
        set { UIView.topConstraintAssociation[self] = newValue }
    }
    
    var bottomConstraint: NSLayoutConstraint {
        get { return UIView.bottomConstraintAssociation[self] ?? NSLayoutConstraint() }
        set { UIView.bottomConstraintAssociation[self] = newValue }
    }
    
    var leadingConstraint: NSLayoutConstraint {
        get { return UIView.leadingConstraintAssociation[self] ?? NSLayoutConstraint() }
        set { UIView.leadingConstraintAssociation[self] = newValue }
    }
    
    var trailingConstraint: NSLayoutConstraint {
        get { return UIView.trailingConstraintAssociation[self] ?? NSLayoutConstraint() }
        set { UIView.trailingConstraintAssociation[self] = newValue }
    }
    
    var centerXConstraint: NSLayoutConstraint {
        get { return UIView.centerXConstraintAssociation[self] ?? NSLayoutConstraint() }
        set { UIView.centerXConstraintAssociation[self] = newValue }
    }
    
    var centerYConstraint: NSLayoutConstraint {
        get { return UIView.centerYConstraintAssociation[self] ?? NSLayoutConstraint() }
        set { UIView.centerYConstraintAssociation[self] = newValue }
    }
    
    var widthConstraint: NSLayoutConstraint {
        get { return UIView.widthConstraintAssociation[self] ?? NSLayoutConstraint() }
        set { UIView.widthConstraintAssociation[self] = newValue }
    }
    
    var heightConstraint: NSLayoutConstraint {
        get { return UIView.heightConstraintAssociation[self] ?? NSLayoutConstraint() }
        set { UIView.heightConstraintAssociation[self] = newValue }
    }

    func setLeading(_ view: UIView?, constant: CGFloat = 0) {
        if validate(view: view) {
            self.leadingConstraint = leadingAnchor.constraint(equalTo: view!.leadingAnchor, constant: constant)
            self.leadingConstraint.isActive = true
        }
    }
    
    func setAfter(_ view: UIView?, constant: CGFloat = 0) {
        if validate(view: view) {
            self.leadingConstraint = leadingAnchor.constraint(equalTo: view!.trailingAnchor, constant: constant)
            self.leadingConstraint.isActive = true
        }
    }
    
    func setTrailing(_ view: UIView?, constant: CGFloat = 0) {
        if validate(view: view) {
            self.trailingConstraint = trailingAnchor.constraint(equalTo: view!.trailingAnchor, constant: -constant)
            self.trailingConstraint.isActive = true
        }
    }
    
    func setBefore(_ view: UIView?, constant: CGFloat = 0) {
        if validate(view: view) {
            self.trailingConstraint = trailingAnchor.constraint(equalTo: view!.leadingAnchor, constant: -constant)
            self.trailingConstraint.isActive = true
        }
    }
    
    
    func setTop(_ view: UIView?, constant: CGFloat = 0) {
        if validate(view: view) {
            self.topConstraint = topAnchor.constraint(equalTo: view!.topAnchor, constant: constant)
            self.topConstraint.isActive = true
        }
    }
    
    func setBelow(_ view: UIView?, constant: CGFloat = 0) {
        if validate(view: view) {
            self.topConstraint = topAnchor.constraint(equalTo: view!.bottomAnchor, constant: constant)
            self.topConstraint.isActive = true
        }
    }
    
    func setBelow(_ view: UIView?, greaterThanConstant constant: CGFloat?) {
        if validate(view: view) {
            self.topConstraint = topAnchor.constraint(greaterThanOrEqualTo: view!.bottomAnchor, constant: constant ?? 0)
            self.topConstraint.isActive = true
        }
    }
    
    
    func setAbove(_ view: UIView?, constant: CGFloat = 0) {
        if validate(view: view) {
            bottomConstraint = bottomAnchor.constraint(equalTo: view!.topAnchor, constant: -constant)
            bottomConstraint.isActive = true
        }
    }
    
    func setBottom(_ view: UIView?, constant: CGFloat = 0) {
        if validate(view: view) {
            bottomConstraint = bottomAnchor.constraint(equalTo: view!.bottomAnchor, constant: -constant)
            bottomConstraint.isActive = true
        }
    }
    
    func setBottom(_ view: UIView?, greaterThanConstant constant: CGFloat?) {
        if validate(view: view) {
            bottomConstraint = bottomAnchor.constraint(greaterThanOrEqualTo: view!.bottomAnchor, constant: constant ?? 0)
            bottomConstraint.isActive = true
        }
    }
    
    func setCenterX(_ view: UIView?, constant: CGFloat = 0) {
        if validate(view: view) {
            centerXConstraint = centerXAnchor.constraint(equalTo: view!.centerXAnchor, constant: constant)
            centerXConstraint.isActive = true
        }
    }
    
    func setCenterY(_ view: UIView?, constant: CGFloat = 0) {
        if validate(view: view) {
            centerYConstraint = centerYAnchor.constraint(equalTo: view!.centerYAnchor, constant: constant)
            centerYConstraint.isActive = true
        }
    }
    
    func setCenter(_ view: UIView?, constant: CGFloat = 0) {
        if validate(view: view) {
            centerYConstraint = centerYAnchor.constraint(equalTo: view!.centerYAnchor, constant: constant)
            centerYConstraint.isActive = true
            
            centerXConstraint = centerXAnchor.constraint(equalTo: view!.centerXAnchor, constant: constant)
            centerXConstraint.isActive = true
        }
    }
    
    func setViewWidth(_ constant: CGFloat) {
        if validate(view: self) {
            widthConstraint = widthAnchor.constraint(equalToConstant: constant)
            widthConstraint.isActive = true
        }
    }
    
    func setViewHeight(_ constant: CGFloat) {
        if validate(view: self) {
            heightConstraint = heightAnchor.constraint(equalToConstant: constant)
            heightConstraint.isActive = true
        }
    }
    
    func setViewSize(_ size: CGSize) {
        if validate(view: self) {
            setViewWidth(size.width)
            setViewHeight(size.height)
        }
    }
    
    func setConstraintsEqualTo(_ view: UIView?, innerPadding padding: CGFloat = 0) {
        if validate(view: self) {
            leadingConstraint = leadingAnchor.constraint(equalTo: view!.leadingAnchor, constant: padding)
            leadingConstraint.isActive = true
            trailingConstraint = trailingAnchor.constraint(equalTo: view!.trailingAnchor, constant: -padding)
            trailingConstraint.isActive = true
            topConstraint = topAnchor.constraint(equalTo: view!.topAnchor, constant: padding)
            topConstraint.isActive = true
            bottomConstraint = bottomAnchor.constraint(equalTo: view!.bottomAnchor, constant: -padding)
            bottomConstraint.isActive = true
        }
    }
    
    func setLeadingOrigin(_ view: UIView?, point: CGPoint = CGPoint.zero) {
        if validate(view: self) {
            leadingConstraint = leadingAnchor.constraint(equalTo: view!.leadingAnchor, constant: point.x)
            leadingConstraint.isActive = true
            topConstraint = topAnchor.constraint(equalTo: view!.topAnchor, constant: point.y)
            topConstraint.isActive = true
        }
    }
    
    func setTrailingOrigin(_ view: UIView?, point: CGPoint = CGPoint.zero) {
        if validate(view: self) {
            trailingConstraint = trailingAnchor.constraint(equalTo: view!.trailingAnchor, constant: -point.x)
            trailingConstraint.isActive = true
            topConstraint = topAnchor.constraint(equalTo: view!.topAnchor, constant: point.y)
            topConstraint.isActive = true
        }
    }
    
    
    func setSameConstraintViewBelow(_ view: UIView?, padding: CGFloat = 0) {
        if validate(view: self) {
            leadingConstraint = leadingAnchor.constraint(equalTo: view!.leadingAnchor)
            leadingConstraint.isActive = true
            trailingConstraint = trailingAnchor.constraint(equalTo: view!.trailingAnchor)
            trailingConstraint.isActive = true
            topConstraint = topAnchor.constraint(equalTo: view!.bottomAnchor, constant: padding)
            topConstraint.isActive = true
        }
    }
    
    func setSameLeadingTrailing(_ view: UIView?) {
        if validate(view: self) {
            leadingConstraint = leadingAnchor.constraint(equalTo: view!.leadingAnchor)
            leadingConstraint.isActive = true
            trailingConstraint = trailingAnchor.constraint(equalTo: view!.trailingAnchor)
            trailingConstraint.isActive = true
            
        }
    }
    
    func getLeadingConstraint() -> NSLayoutConstraint {
        return leadingConstraint
    }

    func getTrailingConstraint() -> NSLayoutConstraint {
        return trailingConstraint
    }

    func getTopConstraint() -> NSLayoutConstraint {
        return topConstraint
    }

    func getBottomConstraint() -> NSLayoutConstraint {
        return bottomConstraint
    }

    func getHeightConstraint() -> NSLayoutConstraint {
        return heightConstraint
    }

    func getWidthConstraint() -> NSLayoutConstraint {
        return widthConstraint
    }

    func getCenterXConstraint() -> NSLayoutConstraint {
        return centerXConstraint
    }

    func getCenterYConstraint() -> NSLayoutConstraint {
        return centerYConstraint
    }
    
    func validate(view: UIView?) -> Bool {
        self.translatesAutoresizingMaskIntoConstraints = false
        if view == nil {
            return false
        }
        return true
    }
}
