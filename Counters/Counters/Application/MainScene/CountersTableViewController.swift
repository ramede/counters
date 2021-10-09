//
//  CountersTableViewController.swift
//  Counters
//
//  Created by Râmede on 05/10/21.
//

import UIKit

class CountersTableViewController: UITableViewController {
    private var searchBarContainer = UIView()

    // MARK: - Private Properties
    private var countersSearchBar = UISearchBar()
    
    // MARK: - Public Properties
    var dataSource: [String] = ["Apple eaten","Number of times I’ve forgotten my mother’s name because I was high on Frugelés.","Cups of coffee","Records played"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupToolbar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - SerachBar Delegate
extension CountersTableViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

// MARK: - TableView Delegate
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

// MARK: - Private Implementation
private extension CountersTableViewController {
    func setup() {
        setupCountersSearchBar()
        setupNavigationBar()
        setupTableView()
        setupSearchBar()
        setupConstraints()
    }

    func setupCountersSearchBar() {
        countersSearchBar.searchBarStyle = UISearchBar.Style.minimal
        countersSearchBar.placeholder = "Search"
        countersSearchBar.sizeToFit()
        countersSearchBar.isTranslucent = false
        countersSearchBar.backgroundColor = .systemGray6
        countersSearchBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupToolbar() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let counterSumDisplayer = UIBarButtonItem(title: "",style: .plain,target: self,action: nil)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        addButton.tintColor = UIColor(named: "AccentColor")
        navigationController?.setToolbarHidden(false, animated: true)
        setToolbarItems([flexibleSpace, counterSumDisplayer, flexibleSpace, addButton], animated: true)
    }
    
    func setupNavigationBar() {
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: nil, action: nil)
        editButton.tintColor = UIColor(named: "AccentColor")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.setStatusBar(backgroundColor: .systemGray6)
        navigationItem.title = "Couters"
        navigationItem.leftBarButtonItem = editButton
    }
    
    func setupTableView() {
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
    
    func setupSearchBar() {
        countersSearchBar.delegate = self
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            countersSearchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            countersSearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

private extension CountersTableViewController {
    @objc func addTapped() {
        let viewController = CreateCounterViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

