//
//  CollectionViewController.swift
//  TestTableView
//
//  Created by Louis Basile on 5/7/18.
//  Copyright © 2018 Louis Basile. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        setupCollectionView()
        setupNavigation()
        setupRefreshControl()
        setupSyncBanner()
        title = "CollectionView"
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupNavigation() {
        showBannerButton = UIBarButtonItem(title: "Show Banner", style: .plain, target: self, action: #selector(toggleShowBanner))
        navigationItem.rightBarButtonItem = showBannerButton
    }
    
    func setupSyncBanner() {
        syncBanner = SyncBanner()
        syncBanner.attach(to: self, above: collectionView)
    }
    
    func setupRefreshControl() {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(requestRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
        collectionView.addSubview(refresher)
    }
    
    @objc func requestRefresh() {
        demoTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
            self.collectionView.refreshControl?.endRefreshing()
        }
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

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let numRows = collectionView.numberOfItems(inSection: indexPath.section)
        cell.backgroundColor = UIColor(white: 0, alpha: CGFloat(indexPath.row)/CGFloat(numRows) + 0.1)
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
}
