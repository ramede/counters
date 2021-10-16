//
//  CountersTableViewController.swift
//  Counters
//
//  Created by Râmede on 05/10/21.
//

import UIKit

protocol CountersTableViewDisplayable: AnyObject {
    func displayLoad(_ isLoading: Bool)
    func displayError()
    func displayCounters(with counters: [Counter])
    func dismissCounter()
    func displayDeleteActionSheet()
    func displaySummaryInfo()
    func displayCount(indexPath: IndexPath, count: Int)
    func dismissDeletedCounters(_ countersIndexes: [IndexPath?])
}

class CountersTableViewController: UITableViewController {
    
    // MARK: - Private Properties
    private var searchController = UISearchController(searchResultsController: nil)
    private let activityIndicator = UIActivityIndicatorView()
    private var allCounters: [Counter] = []
    private var filteredCounters: [Counter] = []
    
    private var interactor: CountersTableViewInteractable
    
    init(interactor: CountersTableViewInteractable) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor.loadInitialInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        setupToolbarAsDefaultMode()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - Private Implementation
private extension CountersTableViewController {
    func setup() {
        setupNavigationBar()
        setupSerachController()
        setupActivityIndicator()
        setupTableView()
        setupConstraints()
    }
    
    func setupSerachController() {
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.automaticallyShowsScopeBar = false
        searchController.searchResultsUpdater = self
        
        searchController.searchBar.backgroundColor = .systemGray6
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = .systemGray6
    }
    
    func setupActivityIndicator() {
        activityIndicator.color = UIColor(named: "AccentColor")
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
        tableView.tableHeaderView = searchController.searchBar
        tableView.backgroundColor = .systemGray5
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UIScreen.main.bounds.height * 65 / 100
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.register(CountersTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CountersEmptyStateTableViewCell.self, forCellReuseIdentifier: "emptyState")
        tableView.backgroundView = activityIndicator
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchController.searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchController.searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

private extension CountersTableViewController {
    @objc func addTapped() {
        let viewController = CreateCounterViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func deleteTapped() {
        let selectedCells = tableView.visibleCells.filter({ $0.isSelected})
        let countersIndexes = selectedCells.map({ tableView.indexPath(for: $0) })
        let countersCells = selectedCells.map({ $0 as? CountersTableViewCell })
        let counterId = countersCells.map({ $0?.countId })
        interactor.deleteCounters(countersId: counterId, countersIndexes: countersIndexes)
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
    
    @objc private func refresh() {
        interactor.getCounters()
    }
}

// MARK: - SearchBar Delegate
extension CountersTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
}

extension CountersTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        if searchText.count == 0 {
            filteredCounters = allCounters
            tableView.reloadData()
            return
        }
        
        //filteredCounters = allCounters.filter { $0.localizedCaseInsensitiveContains(searchText) }
        tableView.reloadData()
    }
}

// MARK: - TableView Delegate
extension CountersTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredCounters.count == 0 {
            return 1
        }
        return filteredCounters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if filteredCounters.count == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "emptyState",
                for: indexPath
            ) as? CountersEmptyStateTableViewCell else { return UITableViewCell() }
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as? CountersTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.selectedBackgroundView?.isHidden = true
        cell.tintColor = UIColor(named: "AccentColor")
        cell.countId = filteredCounters[indexPath.row].id
        cell.counterTitle = filteredCounters[indexPath.row].title
        cell.count = filteredCounters[indexPath.row].count
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

extension CountersTableViewController: CountersTableViewCellDelegate {
    func didIncrementTapped(cell: CountersTableViewCell, countId: String?) {
        if let indexPath = tableView.indexPath(for: cell) {
            interactor.countIncrement(countId: countId, counterIndex: indexPath)
        }
    }
    
    func didDecrementTapped(cell: CountersTableViewCell, countId: String?) {
        if let indexPath = tableView.indexPath(for: cell) {
            interactor.countDecrement(countId: countId, counterIndex: indexPath)
        }
    }
}

extension CountersTableViewController: CountersTableViewDisplayable {
    func displayLoad(_ isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading {
                self.activityIndicator.startAnimating()
                return
            }
            self.activityIndicator.stopAnimating()
        }
    }
    
    func displayError() {
        
    }
    
    func displayCounters(with counters: [Counter]) {
        allCounters = counters
        filteredCounters = counters
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func dismissCounter() {
        
    }
    
    func displayDeleteActionSheet() {
        
    }
    
    func displaySummaryInfo() {
        
    }
    
    func displayCount(indexPath: IndexPath, count: Int) {
        if indexPath.row >= filteredCounters.startIndex && indexPath.row < filteredCounters.endIndex {
            filteredCounters[indexPath.row].count = count
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
        }
    }
    
    func dismissDeletedCounters(_ countersIndexes: [IndexPath?]) {
        let nonNullableIndexes = countersIndexes.compactMap { $0 }
        let indexesToRemove = IndexSet(nonNullableIndexes.map({ $0.row }))
        filteredCounters = filteredCounters.enumerated()
            .filter { !indexesToRemove.contains($0.offset) }
            .map { $0.element }
        tableView.deleteRows(at: nonNullableIndexes, with: .fade)
    }
}
