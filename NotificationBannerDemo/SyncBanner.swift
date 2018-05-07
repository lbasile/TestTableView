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
        backgroundColor = UIColor(red:0.86, green:0.93, blue:0.9, alpha:1)
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
        animateHeight(to: height)
    }
    
    public func hide() {
        animateHeight(to: 0)
    }
    
    private func animateHeight(to newHeight: CGFloat) {
        heightConstraint.constant = newHeight
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.superview?.layoutIfNeeded() // this animates constraint changes
            self.weakScrollView?.contentInset = UIEdgeInsetsMake(newHeight, 0, 0, 0)
            self.weakScrollView?.contentOffset = CGPoint(x: 0, y: -newHeight)
        }, completion: nil)
    }
}
