//
//  SyncBanner.swift
//  TestTableView
//
//  Created by Louis Basile on 5/3/18.
//  Copyright © 2018 Louis Basile. All rights reserved.
//

import UIKit

public class SyncBanner: UIButton {
    weak var weakViewController: UIViewController?
    weak var weakScrollView: UIScrollView?
    
    var noHeightConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    var height: CGFloat { return 40.0 }
    
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
        
        noHeightConstraint = heightAnchor.constraint(equalToConstant: 0)
        noHeightConstraint.isActive = true
        
        heightConstraint = heightAnchor.constraint(equalToConstant: height)
        heightConstraint.isActive = false
    }
    
    public func show() {
        noHeightConstraint.isActive = false
        heightConstraint.isActive = true
        animateHeight(to: height)
    }
    
    public func hide() {
        heightConstraint.isActive = false
        noHeightConstraint.isActive = true
        animateHeight(to: 0)
    }
    
    private func animateHeight(to height: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.superview?.layoutIfNeeded()
            self.weakScrollView?.contentInset = UIEdgeInsetsMake(height, 0, 0, 0)
            self.weakScrollView?.contentOffset = CGPoint(x: 0, y: -height)
        }, completion: nil)
    }
}
