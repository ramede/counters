//
//  ItemCreation.swift
//  Counters
//
//  Created by Râmede on 09/10/21.
//

import UIKit

final class ItemCreation: UIView {

    // MARK: - Private Properties
    private var contentView = UIView()
    private var itemTextField = UITextField()
    private var activityView = UIActivityIndicatorView()

    // MARK: - Public Properties
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                showActivityIndicator()
                return
            }
            hideActivityIndicator()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// MARK: - Private Constants
private extension ItemCreation {
    enum Constants {
        enum ContentView {
            static let radius: CGFloat = 8
            static let height: CGFloat = 55
        }
        
        enum ItemTextField {
            static let trailing: CGFloat = -17
            static let leading: CGFloat = 17
        }
        
        enum ActivityIndicator {
            static let trailing: CGFloat = -15
        }
    }
}
    
// MARK: - Private Implementation
private extension ItemCreation {
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        setupContentView()
        setupItemTextField()
        setupActiviyIndicator()
        setupHierarchy()
        setupConstraints()
    }
    
    func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = Constants.ContentView.radius
        contentView.heightAnchor.constraint(equalToConstant: Constants.ContentView.height).isActive = true
        contentView.backgroundColor = .white
    }
    
    func setupItemTextField() {
        itemTextField.translatesAutoresizingMaskIntoConstraints = false
        itemTextField.placeholder = "Cups of coffee"
    }
    
    func setupActiviyIndicator() {
        activityView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupHierarchy() {
        contentView.addSubview(itemTextField)
        contentView.addSubview(activityView)
        addSubview(contentView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            itemTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.ItemTextField.trailing),
            itemTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            itemTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.ItemTextField.leading),
            
            activityView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            activityView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.ActivityIndicator.trailing)
        ])
    }
    
    func showActivityIndicator() {
        activityView.startAnimating()
        itemTextField.isEnabled = false
    }

    func hideActivityIndicator() {
        activityView.stopAnimating()
        itemTextField.isEnabled = true
    }
}
