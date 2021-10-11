//
//  CreateConterViewController.swift
//  Counters
//
//  Created by Râmede on 09/10/21.
//

import UIKit

class CreateCounterViewController: UIViewController {
    private lazy var contentView = CreateCounterView()

    // MARK: - Properties
    
    init() {
      super.init(nibName: nil, bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Private Implementation
private extension CreateCounterViewController {
    func setup() {
        view.backgroundColor = .systemGray5
        title = "Create a counter"
        setupCancelButton()
        setupSaveButton()
    }
    
    func setupCancelButton() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        cancelButton.tintColor = UIColor(named: "AccentColor")
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    func setupSaveButton() {
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        saveButton.tintColor = UIColor(named: "AccentColor")
        navigationItem.rightBarButtonItem = saveButton
    }
}
private extension CreateCounterViewController {
    @objc func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveTapped() {
        contentView.isLoading = true
    }
}
