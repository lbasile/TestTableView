//
//  ScrollViewController.swift
//  NotificationBannerDemo
//
//  Created by Louis Basile on 5/8/18.
//  Copyright © 2018 Louis Basile. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    var showBannerButton: UIBarButtonItem?
    var syncBanner: SyncBanner!
    
    var showBannerTitle: String {
        if syncBanner.isShowing {
            return "Hide Banner"
        }
        return "Show Banner"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupSyncBanner()
        
        title = "ScrollView"
    }
    
    func setupNavigation() {
        showBannerButton = UIBarButtonItem(title: "Show Banner", style: .plain, target: self, action: #selector(toggleShowBanner))
        navigationItem.rightBarButtonItem = showBannerButton
    }
    
    func setupSyncBanner() {
        syncBanner = SyncBanner(image: nil, target: self, action: #selector(openModal))
        syncBanner.titleLabel?.text = "Scrollview Message"
        syncBanner.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        syncBanner.titleLabel.textColor = UIColor.purple
        syncBanner.backgroundColor = UIColor.yellow
        syncBanner.attach(to: self, above: scrollView)
    }
    
    @objc func openModal() {
        print("Scrollview")
    }
    
    @objc func toggleShowBanner() {
        syncBanner.toggle()
        showBannerButton?.title = showBannerTitle
    }
}
