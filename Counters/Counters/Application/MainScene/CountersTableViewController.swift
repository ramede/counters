//
//  CountersTableViewController.swift
//  Counters
//
//  Created by Râmede on 05/10/21.
//

import UIKit

class CountersTableViewController: UITableViewController {
    

    private var searchBarContainer = UIView()
    
    private var countersSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundColor = .systemGray6
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let flexibleSpace: UIBarButtonItem = {
        let buttonItem = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        return buttonItem
    }()
    
    private var editButton: UIBarButtonItem = {
        let buttonItem = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: nil,
            action: nil
        )
        return buttonItem
    }()
    
    private let counterSumDisplayer: UIBarButtonItem = {
        let buttonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: self,
            action: nil
        )
        return buttonItem
    }()
    
    private let addButton: UIBarButtonItem = {
        let buttonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTapped)
        )
        return buttonItem
    }()
    
    var dataSource: [String] = ["Apple eaten","Number of times I’ve forgotten my mother’s name because I was high on Frugelés.","Cups of coffee","Records played"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupSearchBar()
        setupConstraints()
        setupToolbar()
    }
    
    private func setupToolbar() {
        navigationController?.setToolbarHidden(false, animated: true)
        setToolbarItems([flexibleSpace, counterSumDisplayer, flexibleSpace, addButton], animated: true)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.setStatusBar(backgroundColor: .systemGray6)
        navigationItem.title = "Couters"
        navigationItem.leftBarButtonItem = editButton
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = countersSearchBar
        tableView.backgroundColor = .systemGray5
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 180
        tableView.register(CountersTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupSearchBar() {
        countersSearchBar.delegate = self
    }
    
    private func setupConstraints() {
        countersSearchBar.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 0
        ).isActive = true

        countersSearchBar.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: 0
        ).isActive = true
    }
    
    @objc
    private func addTapped() {
        
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
        cell.selectionStyle = .none
        
        cell.counterDescription = dataSource[indexPath.row]
        return cell
    }
}


extension UINavigationController {
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
}
