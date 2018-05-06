//
//  ViewController.swift
//  TestTableView
//
//  Created by Louis Basile on 5/1/18.
//  Copyright © 2018 Louis Basile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var selectAllButton: UIBarButtonItem?
    var syncBanner: SyncBanner!
    
    var selectAllTitle: String {
        if isAllSelected() {
            return "Deselect All"
        }
        return "Select All"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        setupTableView()
        setupSyncBanner()
    }
    
    func setupSyncBanner() {
        syncBanner = SyncBanner()
        syncBanner.attach(to: self, above: tableView)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func setupToolbar() {
        selectAllButton = UIBarButtonItem(title: selectAllTitle, style: .plain, target: self, action: #selector(toggleSelectAll))
        navigationController?.setToolbarHidden(false, animated: false)
        showToolbarItems()
    }
    
    func showToolbarItems() {
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let editButton = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(toggleEdit))
        
        if tableView.isEditing {
            editButton.title = "Cancel"
            setToolbarItems([flexSpace, selectAllButton!, editButton], animated: true)
        } else {
            editButton.title = "Select"
            setToolbarItems([flexSpace, editButton], animated: true)
        }
    }
    
    @objc func toggleEdit() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        
        if tableView.isEditing {
            syncBanner.show()
        } else {
            syncBanner.hide()
        }
        
        showToolbarItems()
    }
    
    @objc func toggleSelectAll() {
        if isAllSelected() {
            deselectAll()
        } else {
            selectAll()
        }
        selectAllButton?.title = selectAllTitle
    }
    
    func isAllSelected() -> Bool {
        return tableView.indexPathsForSelectedRows?.count == tableView.numberOfRows(inSection: 0)
    }
    
    func selectAll() {
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            tableView.selectRow(at: IndexPath(row: row, section: 0), animated: true, scrollPosition: .none)
        }
    }
    
    func deselectAll() {
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            tableView.deselectRow(at: IndexPath(row: row, section: 0), animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let numRows = tableView.numberOfRows(inSection: indexPath.section)
        cell.backgroundColor = UIColor(hue: (CGFloat(indexPath.row)/CGFloat(numRows)), saturation: 0.6, brightness: 1, alpha: 1)
        cell.textLabel?.text = "Here is some repeating text."
//        cell.backgroundColor = UIColor(white: 0, alpha: CGFloat(indexPath.row)/CGFloat(numRows))
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        cell.selectedBackgroundView? = selectedView
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectAllButton?.title = selectAllTitle
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectAllButton?.title = selectAllTitle
    }
}
