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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        title = "CollectionView"
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
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
