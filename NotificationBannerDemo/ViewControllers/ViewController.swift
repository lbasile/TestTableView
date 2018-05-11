//
//  ViewController.swift
//  NotificationBannerDemo
//
//  Created by Louis Basile on 5/11/18.
//  Copyright © 2018 Louis Basile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var showBannerButton: UIBarButtonItem?
    var isShowingBanner = false
    var syncBanner: SyncBanner!
    var showBannerTitle: String {
        if isShowingBanner {
            return "Hide Banner"
        }
        return "Show Banner"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupSyncBanner()
        
        title = "Simple ViewController"
    }
    
    func setupNavigation() {
        showBannerButton = UIBarButtonItem(title: "Show Banner", style: .plain, target: self, action: #selector(toggleShowBanner))
        navigationItem.rightBarButtonItem = showBannerButton
    }
    
    func setupSyncBanner() {
        let image = UIImage(named: "error")
        syncBanner = SyncBanner(image: image, target: self, action: #selector(openModal))
        syncBanner.tintColor = UIColor.white
        syncBanner.titleLabel?.text = "Server could not be reached."
        syncBanner.titleLabel.font = UIFont.systemFont(ofSize: 14)
        syncBanner.titleLabel.textColor = UIColor.white
        syncBanner.backgroundColor = UIColor(red:0.80, green:0.00, blue:0.00, alpha:1.0)
        syncBanner.attach(to: self, above: nil)
    }
    
    @objc func toggleShowBanner() {
        isShowingBanner = !isShowingBanner
        if isShowingBanner {
            syncBanner.show()
        } else {
            syncBanner.hide()
        }
        showBannerButton?.title = showBannerTitle
    }
    
    @objc func openModal() {
        print("Scrollview")
    }
}