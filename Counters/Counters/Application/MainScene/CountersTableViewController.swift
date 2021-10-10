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
        setupToolbarAsDefaultMode()
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

        cell.selectedBackgroundView?.isHidden = true
        cell.tintColor = UIColor(named: "AccentColor")
        cell.counterDescription = dataSource[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if !tableView.isEditing { return }
        let hasSelectedData = !tableView.visibleCells.filter({ $0.isSelected}).isEmpty
        setupToolbarAsBatchDeletionMode(hasSelectedData)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !tableView.isEditing { return }
        let hasSelectedData = !tableView.visibleCells.filter({ $0.isSelected}).isEmpty
        setupToolbarAsBatchDeletionMode(hasSelectedData)
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
    
    func setupToolbarAsDefaultMode() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let counterSumDisplayer = UIBarButtonItem(title: "",style: .plain,target: self,action: nil)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        addButton.tintColor = UIColor(named: "AccentColor")
        navigationController?.setToolbarHidden(false, animated: true)
        setToolbarItems([flexibleSpace, counterSumDisplayer, flexibleSpace, addButton], animated: true)
    }

    func setupToolbarAsBatchDeletionMode(_ hasSeletedData: Bool = false) {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let counterSumDisplayer = UIBarButtonItem(title: "",style: .plain,target: self,action: nil)
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped))
        deleteButton.tintColor = UIColor(named: "AccentColor")
        deleteButton.isEnabled = hasSeletedData
        navigationController?.setToolbarHidden(false, animated: true)
        setToolbarItems([flexibleSpace, counterSumDisplayer, flexibleSpace, deleteButton], animated: true)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.setStatusBar(backgroundColor: .systemGray6)
        navigationItem.title = "Couters"
        setupNavigationBarAsDefaultMode()
    }
    
    func setupNavigationBarAsBatchDeletionMode() {
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        doneButton.tintColor = UIColor(named: "AccentColor")
        navigationItem.leftBarButtonItem = doneButton

        let selectAllButton = UIBarButtonItem(title: "Select All", style: .plain, target: self, action: #selector(selectAllCounter))
        selectAllButton.tintColor = UIColor(named: "AccentColor")
        navigationItem.rightBarButtonItem = selectAllButton
    }

    func setupNavigationBarAsDefaultMode() {
        let doneButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        doneButton.tintColor = UIColor(named: "AccentColor")
        navigationItem.leftBarButtonItem = doneButton
        navigationItem.rightBarButtonItem = nil
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
        tableView.allowsMultipleSelectionDuringEditing = true
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

    @objc func deleteTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
            print("## Delete ###########")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("## Cancel ###########")
        }))
        
        present(alert, animated: true, completion: {
            print("completion block")
        })
    }

    @objc func editTapped() {
        tableView.setEditing(true, animated: true)
        setupNavigationBarAsBatchDeletionMode()
        setupToolbarAsBatchDeletionMode()
    }
    
    @objc func doneTapped() {
        tableView.setEditing(false, animated: true)
        setupNavigationBarAsDefaultMode()
        setupToolbarAsDefaultMode()
    }
    
    @objc func selectAllCounter() {
        let totalRows = tableView.numberOfRows(inSection: 0)
        for row in 0..<totalRows {
            tableView.selectRow(
                at: NSIndexPath(row: row, section: 0) as IndexPath,
                animated: true,
                scrollPosition: UITableView.ScrollPosition.none
            )
        }
        setupToolbarAsBatchDeletionMode(true)
    }
}

