//
//  MainSceneViewController.swift
//  Counters
//
//  Created by Râmede on 05/10/21.
//

import UIKit

class CountersTableViewController: UITableViewController {

    private var coutersSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
    }
    
    private func setupHeader() {
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.title = "Couters"
        let backButton = UIBarButtonItem(title: "Edit", style: .plain, target: nil, action: nil);
        navigationItem.leftBarButtonItem = backButton
        
        tableView.tableHeaderView = coutersSearchBar
        tableView.keyboardDismissMode = .onDrag

        coutersSearchBar.delegate = self
        coutersSearchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        coutersSearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
    }
}

extension CountersTableViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

