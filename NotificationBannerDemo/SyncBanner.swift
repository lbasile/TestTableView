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
    private var image: UIImage?
    
    public var isShowing = false
    public weak var imageView: UIImageView!
    public weak var titleLabel: UILabel!
    
    public required init(image: UIImage?, target: Any?, action: Selector?) {
        super.init(frame: CGRect.zero)
        self.image = image
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented; SyncBanner not intended for storyboard use")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = UIColor.darkGray
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        self.imageView = imageView
        
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        
        // UIImageView's instrinsic size with no image is (-1,-1)
        // We want this to take up 0 width worth of space but instead of takes up as much as possible.
        //
        // Setting a non-required priority width constraint of 0 creates the intended behavior.
        let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: 0)
        widthConstraint.priority = .defaultHigh
        widthConstraint.isActive = true
        
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
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
    
    public func toggle() {
        if !isShowing {
            show()
        } else {
            hide()
        }
    }
    
    public func show() {
        isShowing = true
        heightConstraint.constant = height
        animate(show: true)
    }
    
    public func hide() {
        isShowing = false
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
