//
//  CountersTableViewController.swift
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
    
    var dataSource: [String] = ["UM","DOIS","TRES","QUATRO"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupSearchBar()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Couters"
        let backButton = UIBarButtonItem(title: "Edit", style: .plain, target: nil, action: nil);
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = coutersSearchBar
        tableView.keyboardDismissMode = .onDrag
        tableView.register(CountersTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func setupSearchBar() {
        coutersSearchBar.delegate = self
    }
    
    private func setupConstraints() {
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

extension CountersTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "cell",
                for: indexPath
        ) as? CountersTableViewCell else { return UITableViewCell() }                
        return cell
    }
}


