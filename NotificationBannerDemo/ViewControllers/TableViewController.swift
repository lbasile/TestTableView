//
//  TableViewController.swift
//  TestTableView
//
//  Created by Louis Basile on 5/1/18.
//  Copyright © 2018 Louis Basile. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var demoTimer: Timer?
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
        setupTableView()
        setupRefreshControl()
        setupSyncBanner()
        
        title = "TableView"
    }
    
    func setupNavigation() {
        showBannerButton = UIBarButtonItem(title: "Show Banner", style: .plain, target: self, action: #selector(toggleShowBanner))
        navigationItem.rightBarButtonItem = showBannerButton
    }
    
    func setupSyncBanner() {
        let image = UIImage(named: "grid")
        syncBanner = SyncBanner(image: image, target: self, action: #selector(openModal))
        syncBanner.backgroundColor = UIColor.purple
        syncBanner.attach(to: self, above: tableView)
    }
    
    @objc func openModal() {
        print("do the thing!!")
    }
    
    func setupRefreshControl() {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(requestRefresh), for: .valueChanged)
        tableView.refreshControl = refresher
        tableView.addSubview(refresher)
    }
    
    @objc func requestRefresh() {
        demoTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let numRows = tableView.numberOfRows(inSection: indexPath.section)
        cell.backgroundColor = UIColor(white: 0, alpha: CGFloat(indexPath.row)/CGFloat(numRows) + 0.1)
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        cell.selectedBackgroundView? = selectedView
        
        return cell
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}

