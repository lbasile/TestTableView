//
//  SyncBanner.swift
//  TestTableView
//
//  Created by Louis Basile on 5/3/18.
//  Copyright © 2018 Louis Basile. All rights reserved.
//

import UIKit

public class SyncBanner: UIControl {
    private weak var weakViewController: UIViewController?
    private weak var weakScrollView: UIScrollView?
    
    private var heightConstraint: NSLayoutConstraint!
    private var height: CGFloat { return 40.0 }
    
    public var image: UIImage?
    
    public convenience init(image: UIImage?, target: Any?, action: Selector?) {
        self.init(frame: CGRect.zero)
        self.image = image
        
        if let action = action {
            self.addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func attach(to: UIViewController, above: UIScrollView?) {
        weakViewController = to
        weakScrollView = above
        
        to.view.addSubview(self)
        
        topAnchor.constraint(equalTo: to.view.safeAreaLayoutGuide.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: to.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: to.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        heightConstraint = heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.isActive = true
    }
    
    public func show() {
        heightConstraint.constant = height
        animate(show: true)
    }
    
    public func hide() {
        heightConstraint.constant = 0
        animate(show: false)
    }
    
    private func animate(show: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            if let scrollView = self.weakScrollView {
                let insetTop = scrollView.contentInset.top
                let offsetY = scrollView.contentOffset.y
                if show {
                    scrollView.contentInset.top = insetTop + self.height
                    scrollView.contentOffset.y = offsetY - self.height
                } else {
                    scrollView.contentInset.top = insetTop - self.height
                    scrollView.contentOffset.y = offsetY + self.height
                }
            }
            self.superview?.layoutIfNeeded() // this animates constraint changes
        }, completion: nil)
    }
}
