//
//  CountersTableViewCell.swift
//  Counters
//
//  Created by Râmede on 06/10/21.
//

import UIKit


// MARK: - Constants


class CountersTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    private var mainView = UIView()
    private var counterLabel = UILabel()
    private var dividerView = UIView()
    private var descriptionLabel = UILabel()
    private var counterStepper = UIStepper()
    
    // MARK: - Public Properties
    var counterDescription: String = "" {
        didSet {
            descriptionLabel.text = counterDescription
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setup()
    }
    
    @objc
    private func dismissAction() {
    }
    
    @objc
    private func saveImageAction() {
    }
    
}

// MARK: - Private Constants

private extension CountersTableViewCell {
    enum Constants {
        enum MainView {
            static let top: CGFloat = 16
            static let trailing: CGFloat = -16
            static let leading: CGFloat = 16
            static let radius: CGFloat = 8
        }

        enum CounterLabel {
            static let top: CGFloat = 16
            static let trailing: CGFloat = -10
            static let leading: CGFloat = 16
            static let width: CGFloat = 35
        }
        
        enum DescriptionLabel {
            static let top: CGFloat = 16
            static let trailing: CGFloat = -14
            static let bottom: CGFloat = -9
        }
        
        enum CounterStepper {
            static let tailing: CGFloat = -14
            static let bottom: CGFloat = -14
        }
        
        enum DividerView {
            static let width: CGFloat = 2
        }
    }
    
    enum Font {
        enum Counter {
            static let size : CGFloat = 22
            static let bold = UIFont.systemFont(ofSize: 22, weight: .bold)
        }
        
        enum Description {
            static let regular = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
    }
}

// MARK: - Private Implementation
private extension CountersTableViewCell {
    func setup() {
        setupMainView()
        setupCounterLabel()
        setupDividerView()
        setupDescriptionLabel()
        setupCounterStepper()
        setupHierarchy()
        setupConstraints()
    }

    func setupMainView() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.layer.cornerRadius = Constants.MainView.radius
        mainView.backgroundColor = .white
    }
    
    func setupCounterLabel() {
        var font: UIFont = Font.Counter.bold
        if let descriptor = Font.Counter.bold.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: Font.Counter.size)
        }
        
        counterLabel.widthAnchor.constraint(equalToConstant: Constants.CounterLabel.width).isActive = true
        counterLabel.font = font
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.numberOfLines = 0
        counterLabel.textColor = UIColor(named: "AccentColor")
        counterLabel.text = "99" // TODO: Binding
        counterLabel.textAlignment = .right
    }
    
    func setupDividerView() {
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.widthAnchor.constraint(equalToConstant: Constants.DividerView.width).isActive = true
        dividerView.backgroundColor = .systemGray5
    }
    
    func setupDescriptionLabel() {
        descriptionLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.Description.regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textColor = UIColor(named: "DescriptionText")
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupCounterStepper() {
        counterStepper.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupHierarchy() {
        contentView.addSubview(mainView)
        mainView.addSubview(counterLabel)
        mainView.addSubview(dividerView)
        mainView.addSubview(descriptionLabel)
        mainView.addSubview(counterStepper)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.MainView.top),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.MainView.trailing),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.MainView.leading),
            
            counterLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: Constants.CounterLabel.top),
            counterLabel.trailingAnchor.constraint(equalTo: dividerView.trailingAnchor, constant: Constants.CounterLabel.trailing),
            counterLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: Constants.CounterLabel.leading),
            
            dividerView.topAnchor.constraint(equalTo: mainView.topAnchor),
            dividerView.trailingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor, constant: Constants.CounterLabel.trailing),
            dividerView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: Constants.DescriptionLabel.top),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: Constants.DescriptionLabel.trailing),
            descriptionLabel.bottomAnchor.constraint(equalTo: counterStepper.topAnchor, constant: Constants.DescriptionLabel.bottom),
            
            counterStepper.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: Constants.CounterStepper.tailing),
            counterStepper.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: Constants.CounterStepper.bottom)
        ])
    }
}
