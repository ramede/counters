//
//  CreateCounterView.swift
//  Counters
//
//  Created by Râmede on 09/10/21.
//

import UIKit

final class CreateCounterView: UIView {

    // MARK: - Private Properties
    private var counterName = ItemCreation()

    // MARK: - Public Properties
    var isLoading: Bool = false {
        didSet {
            counterName.isLoading = isLoading
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        counterName.delegate = self
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private Constants
private extension CreateCounterView {
    enum Constants {
        enum CounterName {
            static let top: CGFloat = 25
            static let trailing: CGFloat = -12
            static let leading: CGFloat = 12
        }
    }
}

// MARK: - Private Implementation
private extension CreateCounterView {
    func setup() {
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        addSubview(counterName)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            counterName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.CounterName.top),
            counterName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.CounterName.trailing),
            counterName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.CounterName.leading)
        ])
        
    }
}

extension CreateCounterView: ItemCreatingDelegate {
    func itemDidChange(_ value: String) {
        print("## Value ###########")
        print(value)
    }
}
